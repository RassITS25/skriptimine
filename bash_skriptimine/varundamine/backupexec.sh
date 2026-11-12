#!/bin/bash
# ==============================================================================
# Skript: backupexec.sh
# Kirjeldus: Automaatne varundusskript, mis kontrollib vaba ruumi ja olemasolevaid
#            arhiive, valib parima kompressori, arvestab .backupignore failiga,
#            arvutab SHA-256 kontrollsumma, verifitseerib arhiivi avatavuse ja
#            sisu, hoiab alles 3 viimast koopiat ning logib kogu tegevuse.
# ==============================================================================

set -euo pipefail

# --- Põhiseadistused (vastavalt sinu kaustastruktuurile) ---
BASE_DIR="$HOME/skriptimine/bash_skriptimine/varundamine/praks2"
SRC_DIR="$BASE_DIR/src"
BACKUP_DIR="$BASE_DIR/backup"
LOG_DIR="$BASE_DIR/logs"
LOG_FILE="$LOG_DIR/backup.log"
IGNORE_FILE="$BASE_DIR/.backupignore"
KEEP_COUNT=3
TIMESTAMP=$(date '+%F_%H-%M-%S')

# Loo vajalikud siht- ja logikaustad, kui neid veel pole
mkdir -p "$BACKUP_DIR" "$LOG_DIR"

# --- Ajutine kataloog ja automaatne puhastus skripti lõppedes ---
TMP_DIR=$(mktemp -d)
cleanup() {
    rm -rf "$TMP_DIR"
}
trap cleanup EXIT

# --- Logimise ja ekraaniteadete funktsioon ---
log_msg() {
    local level="$1"
    local message="$2"
    local line="[ $(date '+%F %T') ] [$level]$message"
    echo "$line"
    echo "$line" >> "$LOG_FILE"
}

log_msg "INFO" "=================================================="
log_msg "INFO" "BACKUP START (ajutine töökaust: $TMP_DIR)"

# 1. Kontrolli, kas lähtekaust eksisteerib
if [ ! -d "$SRC_DIR" ]; then
    log_msg "VIGA" "Lähtekausta '$SRC_DIR' ei leitud! Varundamine katkestatud."
    exit 1
fi

# 2. Vaba kettaruumi kontroll (nõuame vähemalt lähtekausta mahu + 10% varu)
SRC_SIZE=$(du -sb "$SRC_DIR" | awk '{print $1}')
FREE_SPACE=$(df -B1 "$BACKUP_DIR" | awk 'NR==2{print $4}')
REQUIRED_SPACE=$(( SRC_SIZE + SRC_SIZE / 10 ))

log_msg "INFO" "Lähtekausta maht: ${SRC_SIZE} baiti \vert{} Vaba kettaruum:${FREE_SPACE} baiti"

if [ "$FREE_SPACE" -le "$REQUIRED_SPACE" ]; then
    log_msg "VIGA" "Vaba ruumi ei ole piisavalt (vaja vähemalt ${REQUIRED_SPACE} baiti)! Varundamine katkestatud."
    exit 1
else
    log_msg "OK" "Vaba kettaruumi on piisavalt."
fi

# 3. Parima saadaoleva kompressori valik (eelistus: zstd -> xz -> gzip)
TAR_COMP_ARGS=()
DECOMP_ARGS=()
EXT=""

if command -v zstd >/dev/null 2>&1; then
    EXT="tar.zst"
    TAR_COMP_ARGS=(-I "zstd -19 -T0")
    DECOMP_ARGS=(-I "zstd -d")
    log_msg "INFO" "Valitud parim kompressor: zstd (.$EXT)"
elif command -v xz >/dev/null 2>&1; then
    EXT="tar.xz"
    TAR_COMP_ARGS=(-J)
    DECOMP_ARGS=(-J)
    log_msg "INFO" "zstd puudub, valitud kompressor: xz (.$EXT)"
else
    EXT="tar.gz"
    TAR_COMP_ARGS=(-z)
    DECOMP_ARGS=(-z)
    log_msg "INFO" "zstd ja xz puuduvad, valitud kompressor: gzip (.$EXT)"
fi

ARCHIVE_NAME="src_${TIMESTAMP}.${EXT}"
TMP_ARCHIVE="$TMP_DIR/$ARCHIVE_NAME"
FINAL_ARCHIVE="$BACKUP_DIR/$ARCHIVE_NAME"

# 4. Kontrolli, kas sama nimega arhiiv on juba olemas
if [ -e "$FINAL_ARCHIVE" ]; then
    log_msg "VIGA" "Arhiiv '$FINAL_ARCHIVE' on juba olemas! Ülekirjutamise vältimiseks katkestatud."
    exit 1
fi

# 5. .backupignore faili kontroll
EXCLUDE_ARGS=()
if [ -f "$IGNORE_FILE" ]; then
    EXCLUDE_ARGS=(--exclude-from="$IGNORE_FILE")
    log_msg "INFO" "Leiti välistusfail '$IGNORE_FILE' – rakendan reegleid."
elif [ -f "$SRC_DIR/.backupignore" ]; then
    EXCLUDE_ARGS=(--exclude-from="$SRC_DIR/.backupignore")
    log_msg "INFO" "Leiti välistusfail '$SRC_DIR/.backupignore' – rakendan reegleid."
else
    log_msg "HOIATUS" "Faili .backupignore ei leitud – arhiveerin kõik failid ilma välistusteta."
fi

# 6. Arhiivi loomine ajutisse kausta
log_msg "INFO" "Alustan arhiivi pakkimist: $ARCHIVE_NAME ..."
if ! tar "${EXCLUDE_ARGS[@]}" "${TAR_COMP_ARGS[@]}" -cf
