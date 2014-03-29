#/bin/bash

#Author:	Paolo Stivanin <https://github.com/polslinux>
#SLAE ID:	526

if [ -z "$1" ];then
	echo "Usage: $0 filename"
	exit -1
fi

OUT_FILE=${1%.*}

echo "[+] Compiling with gcc..."
if [ "$(uname -m)" == "x86_64" ];then
	gcc -m32 -fno-stack-protector -z execstack $1 -o ${OUT_FILE}
else
	gcc -fno-stack-protector -z execstack $1 -o ${OUT_FILE}
fi
echo "[+] Done!"
