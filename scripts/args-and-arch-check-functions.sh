# this file is supposed to be sourced by the get-files, create-fs and create-image shell scripts

if [ "$#" != "3" ]; then
  echo ""
  echo "usage: ${0} system arch release"
  echo ""
  echo "possible system options:"
  for i in $(ls systems); do
    echo -n "- "${i}" - "; cat systems/${i}/arch.txt
  done
  echo ""
  echo "possible arch options:"
  echo "- armv7l - 32bit (can also be chosen for an aarch64 arch)"
  echo "- aarch64 - 64bit"
  echo "- i686 - 32bit (can also be chosen for an x86_64 arch)"
  echo "- x86_64 - 64bit"
  echo "- riscv64 - 64bit (wip and works only with sidriscv below)"
  echo ""
  echo "possible release options:"
  echo "- focal - ubuntu focal (deprecated)"
  echo "- jammy - ubuntu jammy"
  echo "- bullseye - debian bullseye (deprecated)"
  echo "- bookworm - debian bookworm"
  echo "- sidriscv - debian sid (wip and riscv only as bookworm is not useable yet"
  echo ""
  echo "example: ${0} odroid_u3 armv7l focal"
  echo ""
  exit 1
fi

if [ "${2}" = "armv7l" ] || [ "${2}" = "aarch64" ]; then
  POSSIBLE_TARGET_HOST="aarch64"
fi

if [ "${2}" = "i686" ] || [ "${2}" = "x86_64" ]; then
  POSSIBLE_TARGET_HOST="x86_64"
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

if [ "${2}" = "i686" ] && [ "${3}" = "focal" ] || [ "${2}" = "i686" ] && [ "${3}" = "jammy" ]; then
  echo ""
  echo "the target arch i686 is only supported for debian bullseye and bookworm as there is no i686 build of ubuntu focal or jammy - giving up"
  echo ""
  exit 1
fi
