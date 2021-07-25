// SPDX-FileCopyrightText: Omar Sandoval <osandov@osandov.com>
// SPDX-License-Identifier: MIT

#include <fcntl.h>
#include <getopt.h>
#include <inttypes.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <linux/btrfs.h>
#include <linux/btrfs_tree.h>
#include <asm/byteorder.h>

#define le16_to_cpu __le16_to_cpu
#define le32_to_cpu __le32_to_cpu
#define le64_to_cpu __le64_to_cpu

static const char *progname = "btrfs_map_physical";

static void usage(bool error)
{
	fprintf(error ? stderr : stdout,
		"usage: %s [OPTION]... PATH\n"
		"\n"
		"Map the logical and physical extents of a file on Btrfs\n\n"
		"Pipe this to `column -ts $'\\t'` for prettier output.\n"
		"\n"
		"Btrfs represents a range of data in a file with a \"file extent\". Each\n"
		"file extent refers to a subset of an \"extent\". Each extent has a\n"
		"location in the logical address space of the filesystem belonging to a\n"
		"\"chunk\". Each chunk maps has a profile (i.e., RAID level) and maps to\n"
		"one or more physical locations, or \"stripes\", on disk. The extent may be\n"
		"\"encoded\" on disk (currently this means compressed, but in the future it\n"
		"may also be encrypted).\n"
		"\n"
		"An explanation of each printed field and its corresponding on-disk data\n"
		"structure is provided below:\n"
		"\n"
		"FILE OFFSET        Offset in the file where the file extent starts\n"
		"                   [(struct btrfs_key).offset]\n"
		"FILE SIZE          Size of the file extent\n"
		"                   [(struct btrfs_file_extent_item).num_bytes for most\n"
		"                   extents, (struct btrfs_file_extent_item).ram_bytes\n"
		"                   for inline extents]\n"
		"EXTENT OFFSET      Offset from the beginning of the unencoded extent\n"
		"                   where the file extent starts\n"
		"                   [(struct btrfs_file_extent_item).offset]\n"
		"EXTENT TYPE        Type of the extent (inline, preallocated, etc.)\n"
		"                   [(struct btrfs_file_extent_item).type];\n"
		"                   how it is encoded\n"
		"                   [(struct btrfs_file_extent_item){compression,\n"
		"                   encryption,other_encoding}];\n"
		"                   and its data profile\n"
		"                   [(struct btrfs_chunk).type]\n"
		"LOGICAL SIZE       Size of the unencoded extent\n"
		"                   [(struct btrfs_file_extent_item).ram_bytes]\n"
		"LOGICAL OFFSET     Location of the extent in the filesystem's logical\n"
		"                   address space\n"
		"                   [(struct btrfs_file_extent_offset).disk_bytenr]\n"
		"PHYSICAL SIZE      Size of the encoded extent on disk\n"
		"                   [(struct btrfs_file_extent_offset).disk_num_bytes]\n"
		"DEVID              ID of the device containing the extent\n"
		"                   [(struct btrfs_stripe).devid]\n"
		"PHYSICAL OFFSET    Location of the extent on the device\n"
		"                   [calculated from (struct btrfs_stripe).offset]\n"
		"\n"
		"FILE SIZE is rounded up to the sector size of the filesystem.\n"
		"\n"
		"Inline extents are stored with the metadata of the filesystem; this tool\n"
		"does not have the ability to determine their location.\n"
		"\n"
		"Gaps in a file are represented with a hole file extent unless the\n"
		"filesystem was formatted with the \"no-holes\" option.\n"
		"\n"
		"If the file extent was truncated, hole punched, cloned, or deduped,\n"
		"EXTENT OFFSET may be non-zero and LOGICAL SIZE may be different from\n"
		"FILE SIZE.\n"
		"\n"
		"Options:\n"
		"  -h, --help   display this help message and exit\n",
		progname);
	exit(error ? EXIT_FAILURE : EXIT_SUCCESS);
}

struct stripe {
	uint64_t devid;
	uint64_t offset;
};

struct chunk {
	uint64_t offset;
	uint64_t length;
	uint64_t stripe_len;
	uint64_t type;
	struct stripe *stripes;
	size_t num_stripes;
	size_t sub_stripes;
};

struct chunk_tree {
	struct chunk *chunks;
	size_t num_chunks;
};

static int read_chunk_tree(int fd, struct chunk **chunks, size_t *num_chunks)
{
	struct btrfs_ioctl_search_args search = {
		.key = {
			.tree_id = BTRFS_CHUNK_TREE_OBJECTID,
			.min_objectid = BTRFS_FIRST_CHUNK_TREE_OBJECTID,
			.max_objectid = BTRFS_FIRST_CHUNK_TREE_OBJECTID,
			.min_type = BTRFS_CHUNK_ITEM_KEY,
			.max_type = BTRFS_CHUNK_ITEM_KEY,
			.min_offset = 0,
			.max_offset = UINT64_MAX,
			.min_transid = 0,
			.max_transid = UINT64_MAX,
			.nr_items = 0,
		},
	};
	size_t items_pos = 0, buf_off = 0;
	size_t capacity = 0;
	int ret;

	*chunks = NULL;
	*num_chunks = 0;
	for (;;) {
		const struct btrfs_ioctl_search_header *header;
		const struct btrfs_chunk *item;
		struct chunk *chunk;
		size_t i;

		if (items_pos >= search.key.nr_items) {
			search.key.nr_items = 4096;
			ret = ioctl(fd, BTRFS_IOC_TREE_SEARCH, &search);
			if (ret == -1) {
				perror("BTRFS_IOC_TREE_SEARCH");
				return -1;
			}
			items_pos = 0;
			buf_off = 0;

			if (search.key.nr_items == 0)
				break;
		}

		header = (struct btrfs_ioctl_search_header *)(search.buf + buf_off);
		if (header->type != BTRFS_CHUNK_ITEM_KEY)
			goto next;

		item = (void *)(header + 1);
		if (*num_chunks >= capacity) {
			struct chunk *tmp;

			if (capacity == 0)
				capacity = 1;
			else
				capacity *= 2;
			tmp = realloc(*chunks, capacity * sizeof(**chunks));
			if (!tmp) {
				perror("realloc");
				return -1;
			}
			*chunks = tmp;
		}

		chunk = &(*chunks)[*num_chunks];
		chunk->offset = header->offset;
		chunk->length = le64_to_cpu(item->length);
		chunk->stripe_len = le64_to_cpu(item->stripe_len);
		chunk->type = le64_to_cpu(item->type);
		chunk->num_stripes = le16_to_cpu(item->num_stripes);
		chunk->sub_stripes = le16_to_cpu(item->sub_stripes);
		chunk->stripes = calloc(chunk->num_stripes,
					sizeof(*chunk->stripes));
		if (!chunk->stripes) {
			perror("calloc");
			return -1;
		}
		(*num_chunks)++;

		for (i = 0; i < chunk->num_stripes; i++) {
			const struct btrfs_stripe *stripe;

			stripe = &item->stripe + i;
			chunk->stripes[i].devid = le64_to_cpu(stripe->devid);
			chunk->stripes[i].offset = le64_to_cpu(stripe->offset);
		}

next:
		items_pos++;
		buf_off += sizeof(*header) + header->len;
		if (header->offset == UINT64_MAX)
			break;
		else
			search.key.min_offset = header->offset + 1;
	}
	return 0;
}

static struct chunk *find_chunk(struct chunk *chunks, size_t num_chunks,
				uint64_t logical)
{
	size_t lo, hi;

	if (!num_chunks)
		return NULL;

	lo = 0;
	hi = num_chunks - 1;
	while (lo <= hi) {
		size_t mid = lo + (hi - lo) / 2;

		if (logical < chunks[mid].offset)
			hi = mid - 1;
		else if (logical >= chunks[mid].offset + chunks[mid].length)
			lo = mid + 1;
		else
			return &chunks[mid];
	}
	return NULL;
}

static int print_extents(int fd, struct chunk *chunks, size_t num_chunks)
{
	struct btrfs_ioctl_search_args search = {
		.key = {
			.min_type = BTRFS_EXTENT_DATA_KEY,
			.max_type = BTRFS_EXTENT_DATA_KEY,
			.min_offset = 0,
			.max_offset = UINT64_MAX,
			.min_transid = 0,
			.max_transid = UINT64_MAX,
			.nr_items = 0,
		},
	};
	struct btrfs_ioctl_ino_lookup_args args = {
		.treeid = 0,
		.objectid = BTRFS_FIRST_FREE_OBJECTID,
	};
	size_t items_pos = 0, buf_off = 0;
	struct stat st;
	int ret;

	puts("FILE OFFSET\tFILE SIZE\tEXTENT OFFSET\tEXTENT TYPE\tLOGICAL SIZE\tLOGICAL OFFSET\tPHYSICAL SIZE\tDEVID\tPHYSICAL OFFSET");

	ret = fstat(fd, &st);
	if (ret == -1) {
		perror("fstat");
		return -1;
	}

	ret = ioctl(fd, BTRFS_IOC_INO_LOOKUP, &args);
	if (ret == -1) {
		perror("BTRFS_IOC_INO_LOOKUP");
		return -1;
	}

	search.key.tree_id = args.treeid;
	search.key.min_objectid = search.key.max_objectid = st.st_ino;
	for (;;) {
		const struct btrfs_ioctl_search_header *header;
		const struct btrfs_file_extent_item *item;
		uint8_t type;
		/* Initialize to silence GCC. */
		uint64_t file_offset = 0;
		uint64_t file_size = 0;
		uint64_t extent_offset = 0;
		uint64_t logical_size = 0;
		uint64_t logical_offset = 0;
		uint64_t physical_size = 0;
		struct chunk *chunk = NULL;

		if (items_pos >= search.key.nr_items) {
			search.key.nr_items = 4096;
			ret = ioctl(fd, BTRFS_IOC_TREE_SEARCH, &search);
			if (ret == -1) {
				perror("BTRFS_IOC_TREE_SEARCH");
				return -1;
			}
			items_pos = 0;
			buf_off = 0;

			if (search.key.nr_items == 0)
				break;
		}

		header = (struct btrfs_ioctl_search_header *)(search.buf + buf_off);
		if (header->type != BTRFS_EXTENT_DATA_KEY)
			goto next;

		item = (void *)(header + 1);

		type = item->type;
		file_offset = header->offset;
		if (type == BTRFS_FILE_EXTENT_INLINE) {
			file_size = logical_size = le64_to_cpu(item->ram_bytes);
			extent_offset = 0;
			physical_size = (header->len -
					 offsetof(struct btrfs_file_extent_item,
						  disk_bytenr));
		} else if (type == BTRFS_FILE_EXTENT_REG ||
			   type == BTRFS_FILE_EXTENT_PREALLOC) {
			file_size = le64_to_cpu(item->num_bytes);
			extent_offset = le64_to_cpu(item->offset);
			logical_size = le64_to_cpu(item->ram_bytes);
			logical_offset = le64_to_cpu(item->disk_bytenr);
			physical_size = le64_to_cpu(item->disk_num_bytes);
			if (logical_offset) {
				chunk = find_chunk(chunks, num_chunks,
						   logical_offset);
				if (!chunk) {
					printf("\n");
					fprintf(stderr,
						"could not find chunk containing %" PRIu64 "\n",
						logical_offset);
					return -1;
				}
			}
		}

		printf("%" PRIu64 "\t", file_offset);
		if (type == BTRFS_FILE_EXTENT_INLINE ||
		    type == BTRFS_FILE_EXTENT_REG ||
		    type == BTRFS_FILE_EXTENT_PREALLOC) {
			printf("%" PRIu64 "\t%" PRIu64 "\t", file_size,
			       extent_offset);
		} else {
			printf("\t\t");
		}

		switch (type) {
		case BTRFS_FILE_EXTENT_INLINE:
			printf("inline");
			break;
		case BTRFS_FILE_EXTENT_REG:
			if (logical_offset)
				printf("regular");
			else
				printf("hole");
			break;
		case BTRFS_FILE_EXTENT_PREALLOC:
			printf("prealloc");
			break;
		default:
			printf("type%u", type);
			break;
		}
		switch (item->compression) {
		case 0:
			break;
		case 1:
			printf(",compression=zlib");
			break;
		case 2:
			printf(",compression=lzo");
			break;
		case 3:
			printf(",compression=zstd");
			break;
		default:
			printf(",compression=%u", item->compression);
			break;
		}
		if (item->encryption)
			printf(",encryption=%u", item->encryption);
		if (item->other_encoding) {
			printf(",other_encoding=%u",
			       le16_to_cpu(item->other_encoding));
		}
		if (chunk) {
			switch (chunk->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
			case 0:
				break;
			case BTRFS_BLOCK_GROUP_RAID0:
				printf(",raid0");
				break;
			case BTRFS_BLOCK_GROUP_RAID1:
				printf(",raid1");
				break;
			case BTRFS_BLOCK_GROUP_DUP:
				printf(",dup");
				break;
			case BTRFS_BLOCK_GROUP_RAID10:
				printf(",raid10");
				break;
			case BTRFS_BLOCK_GROUP_RAID5:
				printf(",raid5");
				break;
			case BTRFS_BLOCK_GROUP_RAID6:
				printf(",raid6");
				break;
			default:
				printf(",profile%" PRIu64,
				       (uint64_t)(chunk->type &
						  BTRFS_BLOCK_GROUP_PROFILE_MASK));
				break;
			}
		}
		printf("\t");

		if (type == BTRFS_FILE_EXTENT_INLINE ||
		    type == BTRFS_FILE_EXTENT_REG ||
		    type == BTRFS_FILE_EXTENT_PREALLOC)
			printf("%" PRIu64 "\t", logical_size);
		else
			printf("\t");

		if (type == BTRFS_FILE_EXTENT_REG ||
		    type == BTRFS_FILE_EXTENT_PREALLOC)
			printf("%" PRIu64 "\t", logical_offset);
		else
			printf("\t");

		if (type == BTRFS_FILE_EXTENT_INLINE ||
		    type == BTRFS_FILE_EXTENT_REG ||
		    type == BTRFS_FILE_EXTENT_PREALLOC)
			printf("%" PRIu64 "\t", physical_size);
		else
			printf("\t");

		if (chunk) {
			uint64_t offset, stripe_nr, stripe_offset;
			size_t stripe_index, num_stripes;
			size_t i;

			offset = logical_offset - chunk->offset;
			stripe_nr = offset / chunk->stripe_len;
			stripe_offset = offset - stripe_nr * chunk->stripe_len;
			switch (chunk->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
			case 0:
			case BTRFS_BLOCK_GROUP_RAID0:
				stripe_index = stripe_nr % chunk->num_stripes;
				stripe_nr /= chunk->num_stripes;
				num_stripes = 1;
				break;
			case BTRFS_BLOCK_GROUP_RAID1:
			case BTRFS_BLOCK_GROUP_DUP:
				stripe_index = 0;
				num_stripes = chunk->num_stripes;
				break;
			case BTRFS_BLOCK_GROUP_RAID10: {
				size_t factor;

				factor = chunk->num_stripes / chunk->sub_stripes;
				stripe_index = (stripe_nr % factor *
						chunk->sub_stripes);
				stripe_nr /= factor;
				num_stripes = chunk->sub_stripes;
				break;
			}
			case BTRFS_BLOCK_GROUP_RAID5:
			case BTRFS_BLOCK_GROUP_RAID6: {
				size_t nr_parity_stripes, nr_data_stripes;

				if (chunk->type & BTRFS_BLOCK_GROUP_RAID6)
					nr_parity_stripes = 2;
				else
					nr_parity_stripes = 1;
				nr_data_stripes = (chunk->num_stripes -
						   nr_parity_stripes);
				stripe_index = stripe_nr % nr_data_stripes;
				stripe_nr /= nr_data_stripes;
				stripe_index = ((stripe_nr + stripe_index) %
						chunk->num_stripes);
				num_stripes = 1;
				break;
			}
			default:
				num_stripes = 0;
				break;
			}

			for (i = 0; i < num_stripes; i++) {
				if (i != 0)
					printf("\n\t\t\t\t\t\t\t");
				printf("%" PRIu64 "\t%" PRIu64,
				       chunk->stripes[stripe_index].devid,
				       chunk->stripes[stripe_index].offset +
				       stripe_nr * chunk->stripe_len +
				       stripe_offset);
				stripe_index++;
			}
		}
		printf("\n");

next:
		items_pos++;
		buf_off += sizeof(*header) + header->len;
		if (header->offset == UINT64_MAX)
			break;
		else
			search.key.min_offset = header->offset + 1;
	}
	return 0;
}

int main(int argc, char **argv)
{
	struct option long_options[] = {
		{"help", no_argument, NULL, 'h'},
	};
	int fd, ret;
	struct chunk *chunks;
	size_t num_chunks, i;

	if (argv[0])
		progname = argv[0];

	for (;;) {
		int c;

		c = getopt_long(argc, argv, "h", long_options, NULL);
		if (c == -1)
			break;

		switch (c) {
		case 'h':
			usage(false);
		default:
			usage(true);
		}
	}
	if (optind != argc - 1)
		usage(true);

	fd = open(argv[optind], O_RDONLY);
	if (fd == -1) {
		perror("open");
		return EXIT_FAILURE;
	}

	ret = read_chunk_tree(fd, &chunks, &num_chunks);
	if (ret == -1)
		goto out;

	ret = print_extents(fd, chunks, num_chunks);
out:
	for (i = 0; i < num_chunks; i++)
		free(chunks[i].stripes);
	free(chunks);
	close(fd);
	return ret ? EXIT_FAILURE : EXIT_SUCCESS;
}
