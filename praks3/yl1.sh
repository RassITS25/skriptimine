#!/bin/bash
# Skripti eesmärk on küsida kliendi ees- ja perenimi, ning tervitada teda
# ja salvestada kliendi nime andmed muutujasse

# Küsib andmed
echo -n "Sisesta oma ees- ja perenimi: "

# Loeme andmed muutujasse
read eesnimi perenimi

# Väljastame tervituse ja kinnituse
echo "Tere tulemast, $eesnimi $perenimi"

echo "Sinu eesnimi on $eesnimi ja perenimi on $perenimi"

