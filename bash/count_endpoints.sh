awk -F: '$3~/Start/{split($3,a," ");sub(/\?.*/,"",a[3]);print a[2],a[3]}' $1|sort|uniq -c|sort -rn
