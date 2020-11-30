#!/bin/sh

var=$1
if [ -z ${var} ]; then
  echo "Usage: /bin/bash decrypt.sh mremotengconfig_file.xml"
  exit 0
fi

cat $1 | grep -oP 'Username="\K[^"]+' > tempuserlist
cat $1 | grep -oP 'Password="\K[^"]+' > temppasslist
#cat $1 | grep -oP 'Node Name="\K[^"]+' > systemlist

while read p; do
  if [[ $p != "false" ]] ; then python3 mremoteng_decrypt.py -s $p >> passlist; else echo "false" >> passlist; fi
done <temppasslist

echo "Writing decrypted 'user:password' combinations to file -> decrypted.txt"
paste tempuserlist passlist > decrypted.txt
