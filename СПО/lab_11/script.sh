#!/bin/bash

GRUB_CFG="/boot/grub/grub.cfg"

if [ ! -f "$GRUB_CFG" ]; then
    echo "Конфигурационный файл загрузчика ($GRUB_CFG) не найден."
    exit 1
fi

echo "Список доступных версий ядра для загрузки ОС:"
grep -oP "linux\s+/boot/vmlinuz-\K[^\s]+" "$GRUB_CFG"

echo ""

echo "Версия текущего загруженного ядра:"
uname -r


