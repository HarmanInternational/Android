#!/bin/bash

DUMP_DIR=/tmp/debugfs_dump

mkdir -p $DUMP_DIR

while read line; do
    file=$(echo $line | awk '{print $9}')
    if [ -z "$file" -o "$file" = "." -o "$file" = ".." ]; then
        continue
    fi
    echo "Dumping $file to $DUMP_DIR"
    debugfs -R "rdump $file $DUMP_DIR" system.ext4.img
done
