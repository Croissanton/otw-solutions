#!/bin/bash

function ctrl_c(){
	echo -e "\n\n[!] Saliendo...\n"
	exit 1
}

# Ctrl+C
trap ctrl_c INT

current_file_name="$1"
echo "El archivo a descomprimir recursivamente es $current_file_name"

while :; do

decompressed_file_name="$(7z l $current_file_name 2>/dev/null | tail -n 3 | head -n 1 | awk 'NF{print $NF}')"

if [ $decompressed_file_name ]; then

	if [ -e $decompressed_file_name ]; then
		echo "Ya existe un archivo con nombre $decompressed_file_name"
		rm -rf $current_file_name 2>/dev/null
		exit 2
	fi

	7z x $current_file_name &>/dev/null
	rm -rf $current_file_name 2>/dev/null
	current_file_name=$decompressed_file_name

else echo "El archivo ha sido descomprimido correctamente"; exit 0
fi

done

