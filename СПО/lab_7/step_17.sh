#!/bin/bash
RESULTS_FILE="17time_res.log"
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

echo "=== Шаг 17: Запись 1000 маленьких файлов (16Кб) ==="
for mp in "${mount_points[@]}"; do
  echo "Создание каталога small_files_test в $mp"
  mkdir -p "$mp/small_files_test"
done
for mp in "${mount_points[@]}"; do
  echo "Начало теста записи маленьких файлов в $mp"
  start=$(date +%s.%N)
  for i in $(seq 1 1000); do
    dd if=/dev/zero of="$mp/small_files_test/file_$i" bs=16K count=1 oflag=sync 2>/dev/null
  done
  end=$(date +%s.%N)
  duration=$(echo "$end - $start" | bc)
  result="Шаг17: Общее время записи 1000 файлов в $mp: $duration секунд"
  echo "$result" | tee -a "$RESULTS_FILE"
done
