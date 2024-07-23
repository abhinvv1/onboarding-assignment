#!/bin/bash

map_endpoints() {
    awk -F':' '
    $3 ~ /Started/ {
        split($3, parts, " ")
        method = parts[2]
        endpoint = parts[3]
	sub(/\?.*/, "", endpoint)
	print method, endpoint
    }
    ' "$1"
}

reduce_counts() {
   sort | uniq -c |  awk '{print $2, $3, $1}'
}

map_endpoints tmp_more_than_50 | reduce_counts


