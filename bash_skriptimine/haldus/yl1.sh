#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Kasutusjuhend: $0 <kasutajanimi>"
    exit 1
fi

kasutajanimi=$1
useradd $kasutajanimi -m -s /bin/bash

kasu_tulemus=$?

if [ $kasu_tulemus -eq 0 ]; then
    echo "Kasutaja nimega '$kasutajanimi' on edukalt süsteemi lisatud!"
    echo ""
    echo "--- Sissekanne /etc/passwd failis: ---"
    grep "^$kasutajanimi:" /etc/passwd
    echo ""
    echo "--- Kasutaja kodukataloogi sisu (/home/$kasutajanimi): ---"
    ls -la /home/$kasutajanimi
else
    echo "Viga: Kasutaja '$kasutajanimi' lisamine ebaõnnestus."
    echo "Probleemi kood (exit status): $kasu_tulemus"
    exit $kasu_tulemus
fi
