#!/bin/bash

# Kontrollime, kas skriptile anti täpselt 1 parameeter (failinimi)
if [ $# -ne 1 ]; then
    echo "Kasutusjuhend: $0 <failinimi>"
    exit 1
fi

failinimi=$1

# Kontrollime, kas fail eksisteerib
if [ -f "$failinimi" ]; then
    echo "Fail '$failinimi' on leitud. Alustan kasutajate ja paroolide lisamist..."
    
    # Loeme failist read turvaliselt tsüklisse
    while IFS= read -r rida || [ -n "$rida" ]; do
        # Jätame tühjad read või kommentaarid vahele
        [[ -z "$rida" || "$rida" =~ ^# ]] && continue
        
        echo "-----------------------------------"
        
        # Eraldame reast kasutajanime (koolonile eelnev osa)
        kasutajanimi=$(echo "$rida" | cut -f1 -d:)
        echo "Töötlen kasutajat: $kasutajanimi"
        
        # 1. Loome kasutaja (kutsume välja eelmise skripti)
        sudo bash "$PWD/lisa_kasutaja" "$kasutajanimi"
        
        # 2. Määrame kasutajale parooli failist tuleva rea abil (kasutaja:parool)
        echo "$rida" | sudo chpasswd
        
        if [ $? -eq 0 ]; then
            echo "Parool on kasutajale '$kasutajanimi' edukalt määratud."
        else
            echo "Viga parooli määramisel kasutajale '$kasutajanimi'."
        fi
        
    done < "$failinimi"
    
    echo "-----------------------------------"
    echo "Kõik failis kirjas olevad kasutajad ja paroolid on töödeldud."
else
    echo "Viga: Faili '$failinimi' ei leitud!"
    exit 1
fi
