#!/bin/bash
# php paigaldusskript

# 
PHP=$(dpkg-query -W -f='${Status}' php 2>/dev/null | grep -c 'ok installed')

# php olemasoleku kontroll (kui on puudu)
if [ $PHP -eq 0 ]; then
    echo "php puudub, davai installeerib selle siis!"
    apt update && apt install -y php libapache2-mod-php php-mysql
    echo "php paigaldatud kurat!"
# kui php on olemas
elif [ $PHP -eq 1 ]; then
    echo "php juba eksisteerib"
    which php
fi

