# this file is supposed to be sourced by the get-files, create-fs and create-image shell scripts

if [ "$#" != "3" ]; then
  echo ""
  echo "usage: ${0} system arch release"
  echo ""
  echo "possible system options:"
  for i in $(ls systems); do
    if [ -f systems/${i}/arch-tiny.txt ]; then
      echo -n "- "${i}" - "; cat systems/${i}/arch-tiny.txt
    fi
  done
  echo ""
  echo "possible arch options:"
  echo "- armv7l - 32bit (can also be chosen for an aarch64 arch)"
  echo "- aarch64 - 64bit"
  echo "- riscv64 - 64bit"
  echo ""
  echo "possible release options:"
  echo "- alpine - this is the only release option for tiny images"
  echo ""
  echo "example: ${0} milk_v_duo riscv64 alpine"
  echo ""
  exit 1
fi

if [ "${2}" = "armv7l" ] || [ "${2}" = "aarch64" ]; then
  POSSIBLE_TARGET_HOST="aarch64"
fi

if [ $(uname -m) = ${2} ] || [ $(uname -m) = ${POSSIBLE_TARGET_HOST} ]; then
  echo ""
  echo "the target arch ${2} is supported by the arch this system is running on: $(uname -m) - moving on"
  echo ""
else
  echo ""
  echo "the target arch ${2} is not supported by the arch this system is running on: $(uname -m) - giving up"
  echo ""
  exit 1
fi
