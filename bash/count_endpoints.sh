grep Started $1|sed -E 's/.* ([A-Z]+) "([^?"]+).*/\1 "\2"/'|sort|uniq -c|sort -rn
