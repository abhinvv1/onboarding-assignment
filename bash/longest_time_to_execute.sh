awk '/Start/{r=$0}/Compl/{t=$0;sub(/.*in /,"",t);sub(/ms.*/,"",t);if(+t>+m){m=t;a=r;b=$0}}END{print a,"\n",b}' $1
