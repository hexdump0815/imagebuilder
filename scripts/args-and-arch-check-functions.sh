# this file is supposed to be sourced by the get-files, create-fs and create-image shell scripts

if [ "$#" != "3" ]; then
  echo ""
  echo "usage: $0 system arch release"
  echo ""
  echo "possible system options:"
  echo "- chromebook_snow (armv7l) (not yet supported)"
  echo "- chromebook_veyron (armv7l) (not yet supported)"
  echo "- chromebook_nyan (armv7l) (not yet supported)"
  echo "- allwinner_h3 (armv7l) (not yet supported)"
  echo "- amlogic_m8 (armv7l) (not yet supported)"
  echo "- odroid_u3 (armv7l)"
  echo "- odroid_xu4 (armv7l) (not yet supported)"
  echo "- rockchip_rk322x (armv7l) (not yet supported)"
  echo "- rockchip_rk3288 (armv7l) (not yet supported)"
  echo "- orbsmart_s92_beelink_r89 (armv7l) (not yet supported)"
  echo "- raspberry_pi_2 (armv7l) (not yet supported)"
  echo "- raspberry_pi_3 (aarch64) (not yet supported)"
  echo "- raspberry_pi_4 (aarch64) (not yet supported)"
  echo "- amlogic_gx (aarch64)"
  echo "- allwinner_h6 (aarch64) (not yet supported)"
  echo "- rockchip_rk33xx (aarch64)"
  echo ""
  echo "possible arch options:"
  echo "- armv7l (32bit)"
  echo "- aarch64 (64bit)"
  echo ""
  echo "possible release options:"
  echo "- focal (ubuntu)"
  echo "- bullseye (debian) (not yet supported)"
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
