#!/bin/bash
#SBATCH --job-name=aclip-data
#SBATCH --partition=small
#SBATCH --ntasks=1 --cpus-per-task=2 --mem=8G --time=00:20:00
#SBATCH --output=logs/data-%j.out
# env: SCRIPTS_DIR REALIAD_ROOT DATA_EVAL DATA_FT VENV
source $VENV/bin/activate
python $SCRIPTS_DIR/convert_realiad.py $REALIAD_ROOT $DATA_EVAL $DATA_FT 400
