FROM dlrm_train:latest

ARG PROXY
ENV http_proxy $PROXY
ENV https_proxy $PROXY

ENV DLRM_DIR=/code/train
ENV MODEL_DIR=/data/model
ENV DATA_DIR=/data

WORKDIR /code/inf
ADD . .

RUN apt-get update && apt-get install -y --no-install-recommends \
    emacs \
    python-setuptools \
    python-pip

RUN pip install --upgrade pip
RUN pip install \
    opencv-python \
    absl-py

# build loadgen
RUN cd /tmp && \
    git clone https://github.com/mlperf/inference && \
    cd inference/loadgen && \
    pip install pybind11 && \
    CFLAGS="-std=c++14" python setup.py install && \
    rm -rf mlperf

ENTRYPOINT ["/bin/bash"]
