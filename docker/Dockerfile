ARG BASE_IMAGE=nvcr.io/nvidia/pytorch:23.02-py3

FROM ${BASE_IMAGE}

ENV MP_SIZE 8
ENV DATA_TYPE int4
ENV MAX_SEQ_LEN 10000
ENV CHECKPOINT_PATH /checkpoints
ENV OPTIMIZER FasterTransformer

# requirments
RUN pip install --no-cache-dir \
    pybind11[global] \
    icetk \
    transformers \
    cpm_kernels

# FasterTransformer
ADD . /workspace/FasterTransformer

# RUN bash /FasterTransformer/docker/install.sh
RUN mkdir /workspace/FasterTransformer/build && \
    cd /workspace/FasterTransformer/build && \
    cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_PYT=ON -DBUILD_MULTI_GPU=ON .. && \
    make -j12
# cd /FasterTransformer/build && ./bin/gpt_gemm 1 1 128 96 128 49152 150528 1 8

CMD ["bash", "/workspace/FasterTransformer/docker/start.sh"]
EXPOSE 5000
