#!/bin/bash
# Run once on a LUMI login node (needs internet): clone AnomalyCLIP and create the Python venv.
# usage: bash setup_env.sh <workdir>     (e.g. /scratch/project_46200XXXX/$USER/anomalyclip_demo)
set -e
WORKDIR=${1:?usage: setup_env.sh <workdir>}
mkdir -p "$WORKDIR" && cd "$WORKDIR"
[ -d AnomalyCLIP ] || git clone https://github.com/zqhang/AnomalyCLIP
python3 -m venv venv && source venv/bin/activate
pip install -q -U pip
# ROCm build of PyTorch for LUMI's AMD GPUs; match the ROCm version of your LUMI software stack
pip install -q torch torchvision --index-url https://download.pytorch.org/whl/rocm6.2
pip install -q -r AnomalyCLIP/requirements.txt huggingface_hub pandas
echo "Done. Still needed: ViT-L-14-336px.pt where AnomalyCLIP expects it, and the VisA checkpoint in AnomalyCLIP/checkpoints/."
