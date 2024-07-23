#!/bin/bash
awk -F: '$3 ~ /Started/ {split($3,a," ");sub(/\?.*/,"",a[3]);print a[2],a[3]}' "$1" | sort | uniq -c | awk '{print $1,  $2, $3}' | sort -rn
