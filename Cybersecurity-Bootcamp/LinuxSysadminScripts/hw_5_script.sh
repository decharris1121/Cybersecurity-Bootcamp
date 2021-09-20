#!/bin/bash

# Print freemem of PC
free > ~/backups/freemem/pc_freemem.txt
# Print diskuse of PC
du -h > ~/backups/diskuse/pc_diskuse.txt
# Print freedisk of PC
df -h > ~/backups/freedisk/pc_freedisk.txt
# Print Openlist of PC
ls -lh > ~/backups/openlist/pc_openlist.txt
