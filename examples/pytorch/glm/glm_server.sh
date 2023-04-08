#! /bin/bash

CUDA_LAUNCH_BLOCKING=1

MP_SIZE=${MP_SIZE:-4}
DATA_TYPE=${DATA_TYPE:-int4}
MAX_SEQ_LEN=${MAX_SEQ_LEN:-10000}
CHECKPOINT_PATH=${CHECKPOINT_PATH:-"/checkpoints"}

#MAXSEQLEN=10000
MASTER_PORT=$(shuf -n 1 -i 10000-65535)

#SAMPLING ARGS
TEMP=1.0
#If TOPK/TOPP are 0 it defaults to greedy sampling, top-k will also override top-p
TOPK=5
TOPP=0

script_path=$(realpath $0)
script_dir=$(dirname $script_path)


OPTIONS_NCCL="NCCL_DEBUG=VERSION NCCL_IB_DISABLE=0 NCCL_NET_GDR_LEVEL=2 CUDA_LAUNCH_BLOCKING=0"
export NCCL_DEBUG=INFO
export NCCL_DEBUG_SUBSYS=AL
export CUDA_LAUNCH_BLOCKING=1

DISTRIBUTED_ARGS="--nproc_per_node $MP_SIZE \
                  --nnodes 1 \
                  --node_rank 0 \
                  --master_addr localhost \
                  --master_port $MASTER_PORT"

python -m torch.distributed.launch $DISTRIBUTED_ARGS $script_dir/glm_server.py \
       --world_size $MP_SIZE \
       --tensor_para_size $MP_SIZE \
       --pipeline_para_size 1 \
       --max_seq_len $MAX_SEQ_LEN \
       --ckpt_path $CHECKPOINT_PATH \
       --data_type $DATA_TYPE
