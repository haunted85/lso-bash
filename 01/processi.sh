#!/bin/sh

if [ "$#" -lt "1" ]; then
	echo 'Error: cannot perform any task with no input.' 2>&1
	echo 'Usage: ./processes.sh pid1, [pid2, ..., pidN]'
else
	while [ "$#" -gt "0" ]; do
		length=`echo $1 | wc -c`
		length=$(( $length-1))
		field_no=$((6-$length))
		
		lines=`ps | cut -d' ' -f $field_no | grep "^$1$" | wc -l`
		echo "Linee trovate: $lines"
	
		if [ $lines -gt "0" ]; then
			echo "Creo il file Discendenza-$1..."
			`ps --ppid $1 | cut -d' ' -f $field_no | grep "^$1$" > Discendenza-$1`
		fi
		shift
	done
fi
