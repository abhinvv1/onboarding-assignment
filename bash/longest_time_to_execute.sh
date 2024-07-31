#!/bin/bash

awk '
    /Started/ {request=$0; next}
    /Completed/ {
        for(i=0; i<=NF; i++)
            if($i=="in" && $(i+1)~/[0-9]+ms/) {
                time = $(i+1)
                if(time+0 > max+0) {
                    max = time
                    maxRequest = request
                    maxResponse = $0
                }
                next
            }
    }
    END {
        print maxRequest "\n" maxResponse
    }
' "$1"
