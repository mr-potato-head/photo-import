#!/bin/bash

#$1 dossier d'entrée
#$2 dossier de sortie

for photo in `ls *.{jpeg,jpg,nef} 2> /dev/null`
do
	date=`exiftool -T -createdate -d "%Y:%m:%d" $photo`
	IFS=':' read -r -a array <<< "$date"
        year="${array[0]}"
        month="${array[1]}"
        day="${array[2]}"

	if [ -e $year ] && [ -d $year ]
	then
		#L'année existe déja, on ne la recrée pas
		echo 'Année existe, on vérifie le mois'
		
		if [ -e $month ] && [ -d $month ]
		then
			#Le mois existe, on ne le recrée pas
			echo 'Mois existe, on vérifie le jour'
			
			if [ -e $day ] && [ -d $day ]
			then
				#Le jour existe, on ne le recrée pas
				echo 'Jour existe, on tente la copie'

			else
				# Le jour n'existe pas, on crée le jour
				echo "Création de : $2/$year/$month/$day"

			fi
	
		else
			# Le mois n'existe pas, on crée mois et jour
			echo "Création de : $2/$year/$month/$day"

		fi
	else
		#L'année n'existe pas, on crée toute l'arbo
		echo "Création de : $2/$year/$month/$day"
	fi
done
