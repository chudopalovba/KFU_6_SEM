#!/bin/bash

RESULTS_FILE="19time_res.log"

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
  echo "Создание каталога dir_test в $mp"
  mkdir -p "$test_dir"
  echo "Создание 1000 подкаталогов в $mp"
  start=$(date +%s.%N)
  for i in $(seq 1 1000); do
    mkdir "$test_dir/dir_$i"
  done
  end=$(date +%s.%N)
  duration=$(echo "$end - $start" | bc)
  result="Шаг19: Время создания 1000 подкаталогов в $mp: $duration секунд"
  echo "$result" | tee -a "$RESULTS_FILE"
done
