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
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Algorütmi värk või midagi
if [ $# -ne 1 ]; then
  echo "Käivita see skript koos arvuga, mille paarsust soovid kontrollida.Näiteks: $0 3"
else
  arv=$1
  jaak=$(( $arv % 2))
  if [ $jaak -eq 0 ]; then
    echo "$arv on paaris"
  else
    echo "$arv on paaritu"
  if
if
