#!/bin/sh

# This script starts the QEMU PC emulator, booting from the
# OS floppy disk image

qemu -soundhw pcspk -fda disk_images/mikeos.flp

