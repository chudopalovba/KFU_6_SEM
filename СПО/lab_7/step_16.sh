#!/bin/bash
RESULTS_FILE="16time_res.log"
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
echo "=== Шаг 16: Последовательная запись файла 500 Мб ==="
for mp in "${mount_points[@]}"; do
  echo "Создание каталога largefile_test в $mp"
  mkdir -p "$mp/largefile_test"
done
for mp in "${mount_points[@]}"; do
  echo "Тест последовательной записи в $mp"
  start=$(date +%s.%N)
  dd if=/dev/zero of="$mp/largefile_test/largefile" bs=1M count=500 oflag=sync 2>&1 | tee -a /dev/null
  end=$(date +%s.%N)
  duration=$(echo "$end - $start" | bc)
  result="Шаг16: Время последовательной записи 500 Мб на $mp: $duration секунд"
  echo "$result" | tee -a "$RESULTS_FILE"
done
