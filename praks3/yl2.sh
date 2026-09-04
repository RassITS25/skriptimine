#!/bin/bash


# Andmete küsimine kliendilt
read -p "Sisesta kandiku pikkus (cm): " kandiku_pikkus
read -p "Sisesta kandiku laius (cm): " kandiku_laius
read -p "Sisesta ühe küpsise pikkus (cm): " kypsise_pikkus
read -p "Sisesta ühe küpsise laius (cm): " kypsise_laius
read -p "Sisesta kihtide arv: " kihte
read -p "Sisesta küpsiste arv ühes pakis: " pakis_kypsiseid

# Küpsiste arv ühes kihis pikkusesse ja laiusse
pikkusesse=$(expr $kandiku_pikkus / $kypsise_pikkus)
laiusse=$(expr $kandiku_laius / $kypsise_laius)

# Küpsiste arv ühes kihis kokku
uhes_kihis=$(expr $pikkusesse \* $laiusse)

# Küpsiste koguarv kõigi kihtide peale
kokku_kypsiseid=$(expr $uhes_kihis \* $kihte)

# Vajalik pakkide arv täisarvuna
pakke=$(expr \( $kokku_kypsiseid + $pakis_kypsiseid - 1 \) / $pakis_kypsiseid)

# Tulemused
echo "-------------------------------"
echo "Ühes kihis on küpsiseid: $uhes_kihis tk ($pikkusesse x $laiusse)"
echo "Tordis on küpsiseid kokku: $kokku_kypsiseid tk"
echo "Poest tuleb osta: $pakke pakk(i)"
