MP_SIZE=8
DATA_TYPE=int4

# Run server
docker run -d -it --restart=always --shm-size=10g -p 5000:5000 \
  -v /var/cache/fscache/glm-130b/glm-130b-sat-${MP_SIZE}-${DATA_TYPE}/49300:/checkpoints:ro \
  -v /var/cache/fscache/glm-130b/ice_text.model:/root/.icetk_models/ice_text.model \
  -e MP_SIZE=${MP_SIZE} -e DATA_TYPE=${DATA_TYPE} \
  jt-llm/glm-130b-ft:v1.0.0

# Run App
