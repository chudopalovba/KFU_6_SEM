#!/bin/bash
RESULTS_FILE="1_8.log"
mount_points=(
  /mnt/ext4
)

for mp in "${mount_points[@]}"; do
  echo "Запуск fio для записи на $mp" | tee -a "$RESULTS_FILE"
  fio --name=randwrite_test \
      --filename="$mp/largefile_rand" \
      --size=300M \
      --bs=1M \
      --rw=randwrite \
      --iodepth=16 \
      --numjobs=1 \
      --time_based \
      --runtime=60 \
      --direct=1 | tee -a "$RESULTS_FILE"
done
