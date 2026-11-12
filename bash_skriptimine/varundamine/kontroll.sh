SRC_SIZE=$(du -sb ~/praks2/src | awk '{print $1}')
FREE_SPACE=$(df -B1 ~/praks2/backup | awk 'NR==2{print $4}')
echo "Lähtekausta maht: ${SRC_SIZE} B | Vaba kettaruum: ${FREE_SPACE} B"

if [ "$FREE_SPACE" -le "$SRC_SIZE" ]; then
    echo "VIGA: Vaba ruumi ei ole piisavalt!"
else
    echo "OK: Vaba ruumi on piisavalt."
fi
