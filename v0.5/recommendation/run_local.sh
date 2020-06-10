#!/bin/bash

source ./run_common.sh

common_opt="--config ./mlperf.conf"
OUTPUT_DIR=`pwd`/output/$name
if [ ! -d $OUTPUT_DIR ]; then
    mkdir -p $OUTPUT_DIR
fi

set -x # echo the next command
python python/main.py --profile $profile $common_opt --model $model --model-path $model_path \
       --dataset $dataset --dataset-path $FULL_DATA_DIR \
       --max-ind-range $max_ind_range \
       --output $OUTPUT_DIR $EXTRA_OPS $@
