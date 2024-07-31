#!/bin/bash

awk -F: '$3 ~ /Started/ {
  split($3, request, " ");
  sub(/\?.*/, "", request[3]);
  print request[2], request[3]
}' "$1" | \
sort | \
uniq -c | \
awk '{print $1, $2, $3}' | \
sort -rn
