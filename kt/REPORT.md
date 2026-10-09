# Kontrolltöö report

**Nimi:** Rasmus Mäepalo
**Variant:** skriptimis alused kontrolltöö
**Kuupäev:** 09.10.2026

## Probleem 1 – Kasutajate kontrollimine andis vale tulemuse

- **Skript:** `scripts/user_check.sh`
- **Mida skript näiliselt tegi:** Vaatas üle, kas sisestatud kasutaja üldse eksisteerib
- **Mis oli tegelikult vale:** Skript tegi kontrolli valesti, ning selletõttu arvas ka, et kasutaja mis ei eksisteeri, eksisteerib. Skript võttis vastu isegi tühja vastust
- **Kuidas vea avastasin:** Käivitasin skripti olemasoleva kasutajaga `root`, olematu kasutajaga `kasutaja_keda_ei_ole` ning tühja sisendiga.
- **Millise käsuga kontrollisin:** `bash scripts/user_check.sh kasutaja_keda_ei_ole` ja `bash scripts/user_check.sh ""`
- **Parandus:** Kasutasin käsku `getent passwd`, mis kasutav süsteemi andmebaasi, et leida kasutaja.
- **Kuidas kontrollisin pärast parandust:** `root` ja `user` leiti, ning kasutajad mis ei eksisteerinud, ei leitud.
- **Exit code enne / pärast:** Pärast parandust on olemasoleva kasutaja veakood `0`, puuduva kasutaja veakood `1` ja vigase sisendi veakood `2`.

## Probleem 2 – Teenus ei töötand õigesti

- **Skript:** `scripts/service_check.sh`
- **Mida skript näiliselt tegi:** Vaatas üle, et teenused töötaksid.
- **Mis oli tegelikult vale:** Kasutas `systemctl list-unit-files` käsku, mis vaatas, et fail oleks lihtsalt olemas, kuid ei vaatand, et teenus oleks aktiivne. Samuti oli ka puuduva/mitte-aktiivse teenuse puhul ebatäpne.
- **Kuidas vea avastasin:** Uurisin skripti koodi ja võrdlesin kontrollimise loogikat: `systemctl is-active`.
- **Millise käsuga kontrollisin:** `systemctl is-active ssh`, `systemctl is-active olematu_teenus_123`
- **Parandus:** Vahetasin vana käsu uue käsuga: `systemctl is-active --quiet`.
- **Kuidas kontrollisin pärast parandust:** Panin skripti tööle, ja lasin otsida SSH teenuse, mis oli seadmes olemas, ning skript leidis selle ja andis vastuse millega olin rahul. Testisin samuti ka teenusega, mida ei eksisteerinud masinas, ning skript sai aru, et seda ei ole. Lisasin ka, et skript oleks täpsem puuduva/mitte-aktiivse teenuse puhul. 
- **Exit code pärast:** Töötav teenus `0`, mittetöötav teenus `1`, vigane sisend `2`.

## Probleem 3. Varukoopiaga oli probleem, kus ta tegelt polnud arhiiv

- **Skript:** `scripts/backup.sh`
- **Mida skript näiliselt tegi:** Teeb varukoopia `.tar.gz` ja annab teada edukusest
- **Mis oli tegelikult vale:** Kuidagi oli vale arhiiiv. Skript mida kasutasin checkkas ainult faili olemasolekut.
- **Kuidas vea avastasin:** Testisin oma skripti
- **Millise käsuga kontrollisin:** `file backups/*.tar.gz`, `tar -tzf backups/*.tar.gz`
- **Parandus:** Kasutasin hoopis käsku `tar -czf`, mis loob päris gzip-tihendusega arhiivi.
- **Kuidas kontrollisin pärast parandust:** `file` tuvastas arhiivi, `gzip -t` töötas ja `tar -tzf` näitas kõik kolm faili
- **Exit code enne / pärast:** Ennem andis veakoodi `2`. Pärast parandust viskas `O`


## Uus funktsionaalsus

- **Mida lisasin:** Lisasin uue skripti nimega `scripts/health_report.sh`, mis teostab süsteemikontrolli ja viskab tulemused ka log faili
- **Kuidas töötab:** Skript paneb tööle `system_info.sh`, `disk_check.sh` ja `service_check.sh`, ning viskab tulemusd nii terminali, kui ka log faili: `logs/health_report.log`.
- **Lisavõimalused:** Skripti ei kirjuta varasemaid loge üle, ning lisab ka käivitamisel kuupäiva, kuid ka kellaaja
- **Käivitamine:** `bash scripts/health_report.sh`
- **Kontrollimine:** Panin skripti tööle ja kontrollisin logifaili: `cat logs/health_report.log`. Kõik õnnestus, ning skript viskas tagasi veakoodi `0`. Logide arvu kontrollisin käsuga `grep -c "=== Süsteemikontroll:" logs/health_report.log`.

## Kokkuvõte

Töö käigus kontrollisin viit olemasolevat Bash-skripti ning parandasin neis olevad vead.

Kontrollimiseks võrdlesin skriptide tulemusi tegelike süsteemiandmetega. Varundusega kontrollisin ka, et kõik failid oleks korras, ning tegin kindlaks, et arhiivimine töötab õigelt.
