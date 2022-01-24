#!/bin/bash

cat $1 | sort | uniq | awk '{ print length, $0 }' | sort -n -s | cut -d" " -f 2 > $1.tmp
rm $1
mv $1.tmp $1

