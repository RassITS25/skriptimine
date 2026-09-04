#!/bin/bash

# Küsime kliendilt andmed
read -p "Sisesta reisijate arv: " reisijad
read -p "Sisesta kohtade arv ühes bussis: " kohad

# Täiesti täis busside arv
bussid=$(expr $reisijad / $kohad)

# Maha jäänud inimeste  arv
maha_jaanud=$(expr $reisijad % $kohad)

# Tulemused
echo "-----------------"
echo "Täielikult täidetud busse: $bussid"
echo "Maha jäänud inimesi: $maha_jaanud"
