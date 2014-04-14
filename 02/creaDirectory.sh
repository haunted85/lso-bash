#! /bin/sh

# Si realizzi uno script di shell creaDirectory.sh che accetta come parametro un
# pathname path ed un nome di directory dir e una lista di parole P1, ..., PN e controlla se
# path1 esiste, in caso positivo crea la directory dir nella directory corrente ed in essa copia
# tutti i file regolari contenuti in path e in tutte le sue sottodirectory in cui compare almeno
# una parola P1, ..., PN.

if [ "$#" -lt "3" ]; then
	echo "Error: cannot perform any task without enough input." 2>&1
	echo "Usage: ./creaDirectory <path_name> <dir_name> <word>[, <word2>, ..., <wordN>]"
	exit 1
else
	if [ -d "$1" ]; then
		# Salvo il pathname
		path_name=$1
		# avanzo
		shift

		# Salvo il nome della nuova directory
		dir_name=$1
		# avanzo
		shift

		# Creo la nuova directory
		mkdir $dir_name

		# Se la directory è stata correttamente creata
		if [ "$?" -eq "0" ]; then
			
			# Per ogni file regolare che viene listato nel path specificato e sottodirectory
			for file in `find $path_name -type f` 
			do
				total_matches=0
				# controlla se contiene una delle parole specificate in input
				for param in "$@"
				do
					current_match=0
					current_match=`grep $param $file | wc -l`
					total_matches=$(($total_matches+$current_match))
				done
				#copia nel path
				if [ $total_matches -gt "0" ]; then
					echo "Copying $file in $dir_name..."
					cp $file $dir_name
				fi	
			done	

		else
			echo "Error: cannot create new directory." 2>&1
			exit 3
		fi 

	else
		# se in $1 non c'è un nome di path valido, lo script segnala l'errore ed esce
		echo "$1 does not exist or it is not a directory." 2>&1
		exit 2
	fi
fi