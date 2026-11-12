#!/bin/bash
# ==============================================================================
# Skript: home_backup.sh
# Kirjeldus: Varundab kõikide kasutajate kodukataloogid (/home/*) eraldi
#            .tar.gz arhiividena kausta /home_bcp koos varundamise kuupäevaga.
# Käivitamine: sudo ./home_backup.sh (töötab suvalisest kataloogist)
# ==============================================================================

set -euo pipefail

SOURCE_BASE="/home"
BACKUP_DIR="/home_bcp"
DATE=$(date +%d.%m.%Y)

# Loo sihtkataloog, kui seda veel ei eksisteeri
mkdir -p "$BACKUP_DIR"

echo "=== Alustan kasutajate kodukataloogide varundamist ($DATE) ==="

# Läbi kõik elemendid kaustas /home täistee kaudu (ei sõltu hetke töökataloogist)
for user_path in "$SOURCE_BASE"/*; do
    # Kontrolli, kas tegemist on kataloogiga (välistab üksikud failid)
    if [ -d "$user_path" ]; then
        username=$(basename "$user_path")

        # Välista süsteemne lost+found kaust, kui /home on eraldi partitsioonil
        if [ "$username" = "lost+found" ]; then
            continue
        fi

        archive_name="${username}.${DATE}.tar.gz"
        archive_path="${BACKUP_DIR}/${archive_name}"

        echo "Varundan kasutajat '$username' -> $archive_path ..."
        tar -czf "$archive_path" -C "$SOURCE_BASE" "$username"
        echo "Valmis: $(du -h "$archive_path" | awk '{print $1}')"
    fi
done

echo "=== Kõik kodukataloogid on varundatud kausta $BACKUP_DIR ==="
