# required firmware

for certain functionalities of the qcom sc7180 (7c) like gpu, wifi and most
proably quite a few more to work firmware files are required. this document
is the try to collect information about what is needed and where it can be
obtained from. some of the files are part of the linux-firmware repo and some
will have to be copied from the windows installation of the device as the
firmware is often signed. the firmware files can usually be found at the
path c:/windows32/driverstore/filerepository in the windows installation.
for this and other reasones it is a good idea to leave a windows installation
on the device - only this way it is possible to get firmware and bios updates
and besides that some information useful for linux bringup can be found in
*.inf files and the registry in windows.

## required firmware files for the acer aspire 1

- from: https://gist.githubusercontent.com/TravMurav/7ccd69932260e0477ead267873062e7e/raw/1d554139e68e14d60089fc6ce0f91b86339d6e1e/aspire-1-firmware-list.txt
- via: https://oftc.irclog.whitequark.org/aarch64-laptops/2023-02-21#31912679

```
/lib/firmware/
├── ath10k
│   ├── QCA4019
│   │   └── hw1.0
│   │       ├── board-2.bin
│   │       ├── firmware-5.bin
│   │       └── notice_ath10k_firmware-5.txt
│   ├── QCA6174
│   │   ├── hw2.1
│   │   │   ├── board-2.bin
│   │   │   ├── board.bin
│   │   │   ├── firmware-5.bin
│   │   │   └── notice_ath10k_firmware-5.txt
│   │   └── hw3.0
│   │       ├── board-2.bin
│   │       ├── board.bin
│   │       ├── firmware-4.bin
│   │       ├── firmware-6.bin
│   │       ├── firmware-sdio-6.bin
│   │       ├── notice_ath10k_firmware-4.txt
│   │       ├── notice_ath10k_firmware-6.txt
│   │       └── notice_ath10k_firmware-sdio-6.txt
│   ├── QCA9377
│   │   └── hw1.0
│   │       ├── board-2.bin
│   │       ├── board.bin
│   │       ├── firmware-5.bin
│   │       ├── firmware-6.bin
│   │       ├── firmware-sdio-5.bin
│   │       ├── notice_ath10k_firmware-5.txt
│   │       ├── notice_ath10k_firmware-6.txt
│   │       └── notice_ath10k_firmware-sdio-5.txt
│   ├── QCA9887
│   │   └── hw1.0
│   │       ├── board.bin
│   │       ├── firmware-5.bin
│   │       └── notice_ath10k_firmware-5.txt
│   ├── QCA9888
│   │   └── hw2.0
│   │       ├── board-2.bin
│   │       ├── firmware-5.bin
│   │       └── notice_ath10k_firmware-5.txt
│   ├── QCA988X
│   │   └── hw2.0
│   │       ├── board.bin
│   │       ├── firmware-4.bin
│   │       ├── firmware-5.bin
│   │       ├── notice_ath10k_firmware-4.txt
│   │       └── notice_ath10k_firmware-5.txt
│   ├── QCA9984
│   │   └── hw1.0
│   │       ├── board-2.bin
│   │       ├── firmware-5.bin
│   │       └── notice_ath10k_firmware-5.txt
│   ├── QCA99X0
│   │   └── hw2.0
│   │       ├── board-2.bin
│   │       ├── firmware-5.bin
│   │       └── notice_ath10k_firmware-5.txt
│   └── WCN3990
│       └── hw1.0
│           ├── board-2.bin
│           ├── firmware-5.bin
│           ├── notice.txt_wlanmdsp
│           └── wlanmdsp.mbn
├── qca
│   ├── crbtfw21.tlv
│   ├── crbtfw32.tlv
│   ├── crnv21.bin
│   ├── crnv32.bin
│   ├── crnv32u.bin
│   ├── hpbtfw21.tlv
│   ├── hpnv21.301
│   ├── hpnv21.302
│   ├── hpnv21.bin
│   ├── hpnv21g.301
│   ├── hpnv21g.302
│   ├── hpnv21g.bin
│   ├── htbtfw20.tlv
│   ├── htnv20.bin
│   ├── msbtfw11.mbn
│   ├── msbtfw11.tlv
│   ├── msnv11.bin
│   ├── nvm_00130300.bin
│   ├── nvm_00130302.bin
│   ├── nvm_00230302.bin
│   ├── nvm_00440302.bin
│   ├── nvm_00440302_eu.bin
│   ├── nvm_00440302_i2s_eu.bin
│   ├── nvm_usb_00000200.bin
│   ├── nvm_usb_00000201.bin
│   ├── nvm_usb_00000300.bin
│   ├── nvm_usb_00000302.bin
│   ├── nvm_usb_00000302_eu.bin
│   ├── nvm_usb_00130200.bin
│   ├── nvm_usb_00130200_0104.bin
│   ├── nvm_usb_00130200_0105.bin
│   ├── nvm_usb_00130200_0106.bin
│   ├── nvm_usb_00130200_0107.bin
│   ├── nvm_usb_00130200_0109.bin
│   ├── nvm_usb_00130200_0110.bin
│   ├── nvm_usb_00130201.bin
│   ├── nvm_usb_00130201_010a.bin
│   ├── nvm_usb_00130201_010b.bin
│   ├── nvm_usb_00130201_0303.bin
│   ├── nvm_usb_00130201_gf.bin
│   ├── nvm_usb_00130201_gf_010a.bin
│   ├── nvm_usb_00130201_gf_010b.bin
│   ├── nvm_usb_00130201_gf_0303.bin
│   ├── nvm_usb_00190200.bin
│   ├── rampatch_00130300.bin
│   ├── rampatch_00130302.bin
│   ├── rampatch_00230302.bin
│   ├── rampatch_00440302.bin
│   ├── rampatch_usb_00000200.bin
│   ├── rampatch_usb_00000201.bin
│   ├── rampatch_usb_00000300.bin
│   ├── rampatch_usb_00000302.bin
│   ├── rampatch_usb_00130200.bin
│   ├── rampatch_usb_00130201.bin
│   └── rampatch_usb_00190200.bin
├── qcom
│   ├── a630_gmu.bin
│   ├── a630_sqe.fw
│   └── sc7180-acer-aspire1
│       ├── adspr.jsn
│       ├── adspua.jsn
│       ├── aspire1.tar.xz
│       ├── cdspr.jsn
│       ├── modemr.jsn
│       ├── modemuw.jsn
│       ├── qcadsp7180.mbn
│       ├── qccdsp7180.mbn
│       ├── qcdxkmsuc7180.mbn
│       ├── qcmpss7180.mbn
│       ├── qcmpss7180_nm.mbn
│       ├── qcvss7180.mbn
│       └── wlanmdsp.mbn
├── regulatory.db
└── regulatory.db.p7s
```

## required firmware files for the samsung galaxy book go

this is just a start with files required from the windows installation - more
file are needed as well and the complete list will be very similar to the one
above from the acer aspire 1.
```
qcdxkmsuc7180.mbn
qcvss7180.mbn
qcmpss7180_BTU.mbn
qcmpss7180_nm.mbn
```
those files have to be copied to
/lib/firmware/qcom/sc7180-samsung-galaxy-book-go
