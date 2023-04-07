ARG BASE_IMAGE=nvcr.io/nvidia/pytorch:22.09-py3

FROM ${BASE_IMAGE}

ENV MP_SIZE 4
ENV DATA_TYPE int4
ENV MAX_SEQ_LEN 10000
ENV CHECKPOINT_PATH /checkpoints

RUN mkdir /FasterTransformer
ADD . /FasterTransformer

RUN #bash /FasterTransformer/docker/setenv.sh
RUN pip install \
    pybind11[global] \
    icetk \
    transformers

RUN bash /FasterTransformer/docker/install.sh
CMD ["bash", "/FasterTransformer/docker/start.sh"]
EXPOSE 5000