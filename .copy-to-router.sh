#!/bin/bash

../../../../scripts/ipkg-make-index.sh . > Packages
gzip -c Packages > Packages.gz
scp * root@192.168.0.1:~/packages
