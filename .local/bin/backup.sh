#!/bin/bash

# Run this script as a root cronjob.
# Depends on bash/zsh brace expansion

rsync -aAXHvx --numeric-ids --delete \
    -e "ssh -p 5522" \
    --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/swapfile","/lost+found","/home/*/.cache/*"} \
    / root@192.168.0.2:
