from transformers import pipeline
import transformers
import deepspeed
import torch
import os
from deepspeed.runtime.utils import see_memory_usage


local_rank = int(os.getenv('LOCAL_RANK', '0'))
world_size = int(os.getenv('WORLD_SIZE', '4'))

if local_rank == 0:
    see_memory_usage("before init", True)


import deepspeed

# Initialize the DeepSpeed-Inference engine
model = deepspeed.init_inference(model,
                                 mp_size=4,
                                 dtype=torch.int4,
                                 checkpoint='./checkpoint.json')

output = model('Input String')

if local_rank == 0:
    see_memory_usage("after init_inference", True)