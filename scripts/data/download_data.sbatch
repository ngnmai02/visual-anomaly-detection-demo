#!/bin/bash
#SBATCH --job-name=aclip-dl
#SBATCH --partition=lumid
#SBATCH --ntasks=1 --cpus-per-task=2 --mem=8G --time=04:00:00
#SBATCH --output=logs/download-%j.out
# Real-IAD is gated on Hugging Face: pass HF_TOKEN. Compute nodes have no internet; lumid does (adjust partition if needed).
# env: REALIAD_ROOT VENV HF_TOKEN
set -e
source $VENV/bin/activate
command -v hf >/dev/null || pip install -q -U huggingface_hub
mkdir -p $REALIAD_ROOT
# only the single-view jsons and the 1024px images
hf download Real-IAD/Real-IAD --repo-type dataset --local-dir $REALIAD_ROOT \
    --include "*realiad_jsons_sv*" --include "*1024*"
cd $REALIAD_ROOT
# unpack zips next to each other (jsons -> realiad_jsons_sv/, images -> <object>/)
find . -name "*.zip" | while read z; do unzip -n -q "$z" -d "$(dirname "$z")" && rm "$z"; done
# flatten if the zips/HF layout nested everything under a single folder
for d in realiad_jsons_sv; do
    p=$(find . -maxdepth 3 -type d -name $d | head -1)
    [ "$p" != "./$d" ] && [ -n "$p" ] && mv "$p" ./$d
done
test -d realiad_jsons_sv || { echo "realiad_jsons_sv not found under $REALIAD_ROOT"; exit 1; }
ls $REALIAD_ROOT | head
