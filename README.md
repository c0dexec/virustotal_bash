# VirusTotal Script
The VirusTotal script that is created can be used to read md5 hashes that reside within a file.

```
./vt-file.sh /file/location
```
## Pre-requsites
Need to have curl installed beforehand.
```
sudo apt update && sudo apt install curl
```

# Hashes file
The hashes file that I was using was recording any one who accessing the file "/" directory of my machine. The command I used was,

```
find / -amin -20 -type f -exec md5sum {} \; | awk '{print $1;}' 2>/dev/null > hashes.txt
```

This was for a forensics challenge lab that I was completing for school. One can make use of any hash they feel like.

## References
+ https://www.cyberciti.biz/faq/unix-howto-read-line-by-line-from-file/
+ https://stackoverflow.com/questions/8314499/read-n-lines-at-a-time-using-bash
