#!/bin/bash

RESULTS_FILE="20time_res.log"

mount_points=(
  /mnt/ext2
  /mnt/ext3
  /mnt/ext4
  /mnt/xfs
  /mnt/btrfs
  /mnt/zfs
  /mnt/reiserfs
  /mnt/fat32
  /mnt/ntfs
)

for mp in "${mount_points[@]}"; do
  test_dir="$mp/dir_test"
  echo "Запуск поиска в каталоге $test_dir на $mp"
  start=$(date +%s.%N)
  find "$test_dir" -type d -name "dir_*" > /dev/null
  end=$(date +%s.%N)
  duration=$(echo "$end - $start" | bc)
  result="Шаг20: Время поиска по каталогу в $mp: $duration секунд"
  echo "$result" | tee -a "$RESULTS_FILE"
done
