#!/bin/sh
sed -i \
         -e 's/#52646d/rgb(0%,0%,0%)/g' \
         -e 's/#ffffff/rgb(100%,100%,100%)/g' \
    -e 's/#7a92a0/rgb(50%,0%,0%)/g' \
     -e 's/#ddc87d/rgb(0%,50%,0%)/g' \
     -e 's/#43555e/rgb(50%,0%,50%)/g' \
     -e 's/#ffffff/rgb(0%,0%,50%)/g' \
	"$@"
