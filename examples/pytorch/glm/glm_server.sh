#! /bin/bash

CHECKPOINT_PATH=${CHECKPOINT_PATH:-"/checkpoints"}

MP_SIZE=${MP_SIZE:-8}
PIPELINE_PARA_SIZE=${PIPELINE_PARA_SIZE:-1}
DATA_TYPE=${DATA_TYPE:-int4}

MAX_SEQ_LEN=${MAX_SEQ_LEN:-10000}
LAYER_NUM=${LAYER_NUM:-70}
HEAD_NUM=${HEAD_NUM:-96}
SIZE_PER_HEAD=${SIZE_PER_HEAD:-128}
VOCAB_SIZE=${VOCAB_SIZE:150528}
ROTARY_EMBEDDING_DIM=${ROTARY_EMBEDDING_DIM:-64}

OPTIONS_NCCL="NCCL_DEBUG=VERSION NCCL_IB_DISABLE=0 NCCL_NET_GDR_LEVEL=2 CUDA_LAUNCH_BLOCKING=0"
NCCL_DEBUG=${NCCL_DEBUG:-VERSION}
CUDA_LAUNCH_BLOCKING=${CUDA_LAUNCH_BLOCKING:-0}

#MAXSEQLEN=10000
MASTER_PORT=$(shuf -n 1 -i 10000-65535)

#SAMPLING ARGS
TEMP=1.0
#If TOPK/TOPP are 0 it defaults to greedy sampling, top-k will also override top-p
TOPK=5
TOPP=0

script_path=$(realpath $0)
script_dir=$(dirname $script_path)

DISTRIBUTED_ARGS="--nproc_per_node $MP_SIZE \
                  --nnodes 1 \
                  --node_rank 0 \
                  --master_addr localhost \
                  --master_port $MASTER_PORT"

python -m torch.distributed.launch $DISTRIBUTED_ARGS $script_dir/glm_server.py \
       --world_size $MP_SIZE \
       --tensor_para_size $MP_SIZE \
       --pipeline_para_size $PIPELINE_PARA_SIZE \
       --max_seq_len $MAX_SEQ_LEN \
       --ckpt_path $CHECKPOINT_PATH \
       --data_type $DATA_TYPE \
       --layer_num $LAYER_NUM \
       --head_num $HEAD_NUM \
       --size_per_head $SIZE_PER_HEAD \
       --vocab_size $VOCAB_SIZE \
       --rotary_embedding_dim $ROTARY_EMBEDDING_DIM
