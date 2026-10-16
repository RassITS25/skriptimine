#!/bin/bash

# Kontrollime, kas skriptile anti täpselt 1 parameeter (failinimi)
if [ $# -ne 1 ]; then
    echo "Kasutusjuhend: $0 <failinimi>"
    exit 1
fi

failinimi=$1

# Kontrollime, kas fail eksisteerib ja on tavaline fail
if [ -f "$failinimi" ]; then
    echo "Fail '$failinimi' on leitud. Alustan kasutajate lisamist..."
    
    # Loeme failist read tsüklisse
    while IFS= read -r nimi || [ -n "$nimi" ]; do
        # Jätame tühjad read või kommentaarid vahele, kui neid peaks olema
        [[ -z "$nimi" || "$nimi" =~ ^# ]] && continue
        
        echo "-----------------------------------"
        echo "Töötlen kasutajat: $nimi"
        
        # Kutsume välja eelmises ülesandes tehtud skripti
        # (veendu, et lisa_kasutaja on samas kaustas ja käivitatav)
        bash ./lisa_kasutaja "$nimi"
        
    done < "$failinimi"
    
    echo "-----------------------------------"
    echo "Kõik failis kirjas olevad kasutajad on läbi töödeldud."
else
    echo "Viga: Faili '$failinimi' ei leitud või see pole korrektne fail!"
    exit 1
fi
