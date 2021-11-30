#!/bin/bash

# Only contains non-duplicate hashes
hashes=$(cut -d' ' -f1 $1 | sort -u | grep -e "[0-9a-f]\{32\}" > /tmp/md5hashes.txt );
md5hashes="/tmp/md5hashes.txt";

# Created a while loop which prints 4 line at a time, modified to print lines at rate of 4. https://stackoverflow.com/questions/8314499/read-n-lines-at-a-time-using-bash 
while mapfile -t -n 4 hash && ((${#hash[@]})); do
    for x in "${hash[@]}"; do
      echo "For hash $x the results are:" && curl -s -A 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:60.0) Gecko/20100101 Firefox/60.0' -X POST 'https://www.virustotal.com/vtapi/v2/file/report' --form apikey="ADD-YOUR-HASH" --form resource="$x" |awk -F 'positives\":' '{print "Malware Hits:" $2}'|awk -F' ' '{print $1$2" "$3$6$7}'|sed 's/["}]//g'
    done
    echo "Rate locked at 4 queries/minute" && sleep 60
done < $md5hashes

# Clean up
rm $md5hashes
echo "Bye."