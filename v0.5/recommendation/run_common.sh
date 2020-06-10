#!/bin/bash

#if [ $# -lt 1 ]; then
#    echo "usage: $0 pytorch dlrm [kaggle|terabyte] [cpu|gpu]"
#    exit 1
#fi
if [ "x$DATA_DIR" == "x" ]; then
    echo "DATA_DIR not set" && exit 1
fi
if [ "x$MODEL_DIR" == "x" ]; then
    echo "MODEL_DIR not set" && exit 1
fi
if [ "x$DLRM_DIR" == "x" ]; then
    echo "DLRM_DIR not set" && exit 1
fi


# defaults
backend=pytorch
model=dlrm
dataset=terabyte
device="cpu"

for i in $* ; do
    case $i in
       pytorch) backend=$i; shift;;
       dlrm) model=$i; shift;;
       kaggle|terabyte) dataset=$i; shift;;
       cpu|gpu) device=$i; shift;;
    esac
done
# debuging
# echo $backend
# echo $model
# echo $dataset
# echo $device
# echo $MODEL_DIR
# echo $DATA_DIR
# echo $DLRM_DIR
# echo $EXTRA_OPS

if [ $device == "cpu" ] ; then
    export CUDA_VISIBLE_DEVICES=""
    extra_args=""
else
    extra_args="--use-gpu"
fi
name="$model-$dataset-$backend"


#
# pytorch
#
if [ $name == "dlrm-kaggle-pytorch" ] ; then
    model_path="$MODEL_DIR/ck.pt"
    export FULL_DATA_DIR=${DATA_DIR}/dac
    profile=dlrm-kaggle-pytorch
fi
if [ $name == "dlrm-terabyte-pytorch" ] ; then
    #max_ind_range=10000000
    #model_path="$MODEL_DIR/tb0875_10M.pt"
    max_ind_range=40000000
    model_path="$MODEL_DIR/tb00_40M.pt"
    export FULL_DATA_DIR=${DATA_DIR}/criteo_terabyte
    profile=dlrm-terabyte-pytorch
fi
# debuging
# echo $model_path
# echo $profile
# echo $extra_args

name="$backend-$device/$model"
EXTRA_OPS="$extra_args $EXTRA_OPS"
