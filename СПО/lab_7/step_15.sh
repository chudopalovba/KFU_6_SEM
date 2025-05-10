#!/bin/bash
RESULTS_FILE="15time_res.log"
echo "=== Шаг 15: Чтение файла 16Кб 100 раз - $(date) ===" >> "$RESULTS_FILE"
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
  echo "Подготовка каталога test_16k в $mp"
  mkdir -p "$mp/test_16k"
done

for mp in "${mount_points[@]}"; do
  dd if=/dev/zero of="$mp/test_16k/file_16k" bs=16K count=1 oflag=direct 2>/dev/null
done

for mp in "${mount_points[@]}"; do
  echo "Выполнение теста чтения в $mp"
  start=$(date +%s.%N)
  for i in {1..100}; do
    dd if="$mp/test_16k/file_16k" of=/dev/null bs=16K count=1 iflag=direct 2>/dev/null
  done
  end=$(date +%s.%N)
  duration=$(echo "$end - $start" | bc)
  result="Шаг15: Время чтения 100 раз для $mp: $duration секунд"
  echo "$result" | tee -a "$RESULTS_FILE"
done
