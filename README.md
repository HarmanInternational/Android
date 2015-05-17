split_bootimg.pl script will split boot image to it's components, kernel and ramdisk.
Will unpack the ramdisk and will create a configuration file containing all the needed parameters for repacking the image.

--------
Usage:
split_bootimg.pl <boot image file>

For example :
# ./split_bootimg.pl boot.img
Page size: 2048 (0x00000800)
Kernel size: 4143200 (0x003f3860)
Kernel addr: 0x80008000
Ramdisk size: 323940 (0x0004f164)
Ramdisk addr: 0x81000000
Second size: 0 (0x00000000)
Second addr: 0x80f00000
Tags addr: 0x80000100
Board name: 
Command line: 
Writing parameters config file boot.img-params.conf ... complete.
Writing boot.img-kernel ... complete.
Writing boot.img-ramdisk.gz ... complete.
Unpacking boot.img-ramdisk.gz ... complete.

--------
Usage :
repack_bootimg.pl <kernel> <ramdisk directory> <out image> [parameters conf file]

For Example :
# ./repack_bootimg.pl boot.img-kernel boot.img-ramdisk  myboot.img boot.img-params.conf 
Parsing config file boot.img-params.conf ... complete.
Creating Ramdisk ... complete.
Creating image ... complete.

