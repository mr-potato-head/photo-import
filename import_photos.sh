#!/bin/bash

#$1 dossier d'entrée
#$2 dossier de sortie

initial_dir=`pwd`

input_dir="$(cd "$1"; pwd)"
echo "Input directory: $input_dir"
cd "$initial_dir"
output_dir="$(cd "$2"; pwd)"
echo "Output directory: $output_dir"
cd "$initial_dir"

OIFS="$IFS"
IFS=$'\n'

for photo in `ls -1 "$input_dir"/*.{jpeg,JPEG,jpg,JPG,nef,NEF} 2> /dev/null`
do
	date=`exiftool -T -createdate -d "%Y:%m:%d" $photo`
	IFS=':' read -r -a array <<< "$date"
        year="${array[0]}"
        month="${array[1]}"
        day="${array[2]}"

	filename=`basename $photo`
	echo "$filename"

	if [ $date = "-" ]
	then
		#echo "Try to create folder : $output_dir/undated"
		mkdir -p -v "$output_dir/undated"
		
		#echo "Try to copy : $photo in $output_dir/undated"
		cp -i -v "$photo" "$output_dir/undated/$filename"
	else
		#echo "Try to create folder : $output_dir/$year/$month/$day"
		mkdir -p -v "$output_dir/$year/$month/$day"

		#echo "Try to copy : $photo in $output_dir/$year/$month/$day"
		cp -i -v "$photo" "$output_dir/$year/$month/$day/$filename"
	fi
done
IFS="$OIFS"
