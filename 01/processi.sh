#!/bin/sh

# Controllo che vi sia almeno un PID in input
if [ "$#" -lt "1" ]; then
	# se non c'è, torno un errore sullo std err ed esco dallo script
	echo 'Error: cannot perform any task with no input.' 2>&1
	echo 'Usage: ./processes.sh pid1, [pid2, ..., pidN]'
else
	# finché ci sono argomenti in input da processare
	while [ "$#" -gt "0" ]; do
		# recupera la lunghezza del PID in input
		length=`echo $1 | wc -c`
		length=$(( $length-1))
		# determina il numero corretto di spazi da evitare (max numeri a 6 cifre)
		field_no=$((6-$length))
		
		# controlla se esistono processi con il PID corrente in input
		lines=`ps | cut -d' ' -f $field_no | grep "^$1$" | wc -l`
		echo "Linee trovate: $lines"
	
		# se c'è effettivamente...
		if [ $lines -gt "0" ]; then
			echo "Creo il file Discendenza-$1..."

			# viene creato il file corrispondente con all'interno la discendenza
			`ps --ppid $1 | cut -d' ' -f $field_no | grep "^$1$" > Discendenza-$1`
		fi

		# si passa al PID successivo
		shift
	done
fi
