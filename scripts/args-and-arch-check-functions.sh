# this file is supposed to be sourced by the get-files, create-fs and create-image shell scripts

if [ "$#" != "3" ]; then
  echo ""
  echo "usage: $0 system arch release"
  echo ""
  echo "possible system options:"
  for i in $(ls systems); do
    echo -n "- "$i" - "; cat systems/$i/arch.txt
  done
  echo ""
  echo "possible arch options:"
  echo "- armv7l - 32bit"
  echo "- aarch64 - 64bit"
  echo ""
  echo "possible release options:"
  echo "- focal - ubuntu"
  echo "- bullseye - debian (not yet supported)"
  echo ""
  echo "example: $0 odroid_u3 armv7l focal"
  echo ""
  exit 1
fi

if [ $(uname -m) != ${2} ]; then
  echo ""
  echo "the target arch ${2} is not the same arch this system is running on: $(uname -m) - giving up"
  echo ""
  exit 1
fi
