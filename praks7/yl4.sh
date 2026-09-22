#!/bin/bash
#
read -p "Ridade arv: " read_rows
for (( i=1; i<=read_rows; i++ ))
do
	echo -n "$i. "
	for (( j=1; j<=i; j++ ))
	do
	    echo -n "* "
	done
	echo ""
done
