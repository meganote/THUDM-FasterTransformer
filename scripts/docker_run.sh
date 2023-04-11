set -e
set -x
set -o pipefail

MP_SIZE=8
DATA_TYPE=int4
CUDA_LAUNCH_BLOCKING=1
NVIDIA_VISIBLE_DEVICES=all
OPTIMIZER=NONE

# Run server
docker run -d -it --restart=always --shm-size=10g -p 5000:5000 \
  --name glm-130b-${MP_SIZE}-${DATA_TYPE} \
  -e NVIDIA_VISIBLE_DEVICES=${NVIDIA_VISIBLE_DEVICES} -e CUDA_LAUNCH_BLOCKING=${CUDA_LAUNCH_BLOCKING} \
  -v /var/cache/fscache/glm-130b/glm-130b-sat-${MP_SIZE}-${DATA_TYPE}/49300:/checkpoints:ro \
  -v /var/cache/fscache/glm-130b/ice_text.model:/root/.icetk_models/ice_text.model \
  -e MP_SIZE=${MP_SIZE} -e DATA_TYPE=${DATA_TYPE} \
  -e OPTIMIZER=${OPTIMIZER} \
  jt-llm/glm-130b-ft:v1.0.1

# Run App
