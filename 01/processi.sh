#!/bin/sh

if [ "$#" -lt "1" ]; then
	echo 'Error: cannot perform any task with no input.'
	echo './processes.sh pid1, [pid2, ..., pidN]'
else
	while [ "$#" -gt "0" ]; do
	lines=`ps | cut -d' ' -f 1 | grep "^$1$" | wc -l`
	
	if [ $lines -gt "0" ]; then
		`ps --ppid $1 | cut -d' ' -f 1 | grep "^$1$" > Discendenza-$1`
	fi
	shift
done
fi
