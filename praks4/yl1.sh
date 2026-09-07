#!/bin/bash
#
#  paarsuse kontroll
#
echo -n "Sisesta täisarv: "
read arv
# Teeme kindlaks, et on täisarv
jaak=$(( $arv % 2 ))
if [ $jaak -eq 0 ]
then
   echo "$arv on paaris"
else
   echo "$arv on paaritu"
fi

