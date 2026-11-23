#!/bin/bash
#SBATCH --job-name=aclip-ft
#SBATCH --partition=small-g
#SBATCH --nodes=1 --gpus-per-node=1 --ntasks=1 --cpus-per-task=7 --mem=60G
#SBATCH --time=04:00:00
#SBATCH --output=logs/finetune-%j.out
# env: VENV REPO DATA OUT EPOCHS LR
source $VENV/bin/activate
cd $REPO
python train.py --dataset realiad --train_data_path $DATA --save_path $OUT \
    --features_list 24 --image_size 518 --batch_size 8 --depth 9 --n_ctx 12 --t_n_ctx 4 \
    --epoch $EPOCHS --learning_rate $LR --sigma 4
# keep a stable name for the evaluation job
cp $OUT/epoch_$EPOCHS.pth $OUT/finetuned.pth
