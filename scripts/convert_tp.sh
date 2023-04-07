MP_SIZE=8
BIT_WIDTH=4

python tools/convert_tp.py \
  --input-folder /var/cache/fscache/glm-130b/glm-130b-sat \
  --output-folder /var/cache/fscache/glm-130b/glm-130b-sat-${MP_SIZE}-int${BIT_WIDTH} \
  --target-tp ${MP_SIZE} \
  --quantization-bit-width ${BIT_WIDTH}
