# FasterTransformer

This repository is based on FasterTransformer adapted to GLM-130B, for FasterTransformer, please read the original project.

## Quick Start

Read [inference-with-fastertransformer](https://github.com/THUDM/GLM-130B/blob/main/docs/inference-with-fastertransformer.md).

## Convert Model
docker run -it --rm -v /home/apps/GLM-130B:/home/apps/GLM-130B -v /var/cache/fscache/glm-130b:/var/cache/fscache/glm-130b pytorch:22.09-py3 /bin/bash
cd /home/apps/GLM-130B/GLM-130B-main
python tools/convert_tp.py \
    --input-folder /var/cache/fscache/glm-130b/glm-130b-sat \
    --output-folder /var/cache/fscache/glm-130b/glm-130b-sat-8-int4 \
    --target-tp 8 \
    --quantization-bit-width 4

## Run Model
bash scripts/docker_run.sh

## Run App