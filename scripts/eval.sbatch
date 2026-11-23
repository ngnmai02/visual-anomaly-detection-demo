#!/bin/bash
#SBATCH --job-name=aclip-eval
#SBATCH --partition=small-g
#SBATCH --nodes=1 --gpus-per-node=1 --ntasks=1 --cpus-per-task=7 --mem=60G
#SBATCH --time=02:00:00
#SBATCH --output=logs/eval-%j.out
# env: RESULTS_DIR VENV REPO DATA CKPT TAG
source $VENV/bin/activate
cd $REPO
python test.py --dataset realiad --data_path $DATA --save_path $RESULTS_DIR/$TAG \
    --checkpoint_path $CKPT --features_list 24 --image_size 518 --depth 9 --n_ctx 12 --t_n_ctx 4 --sigma 4
