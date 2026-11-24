## Running the Notebooks (1 GPU Setup)

The demo notebook is designed for interactive use via Jupyter on LUMI.

### 1. Launch Jupyter

Go to: https://www.lumi.csc.fi/ and select **Jupyter** from the app menu.

### 2. Configure the session

Use the following settings:

- **Project**: `project_46XXXXXXX`  
- **Partition**: `dev-g`  
- **Cores**: `7`  
- **Memory**: `60 GiB`  
- **GPUs (MI250)**: `1`  
- **Time**: `02:00:00`  
- **Working directory**: `/scratch/$PROJECT`  
- **Module**: `lumi-multitorch`  (see more info [here](https://lumi-supercomputer.github.io/LUMI-training-materials/User-Coffee-Breaks/20260326-user-coffee-break-LAIF-software-environment/) and [here](https://docs.lumi-supercomputer.eu/laif/software/ai-environment/))

This setup is suitable for:
- Running fine-tuning experiments on a small scale  
- Performing inference interactively


### 3. Get the notebooks

Open a terminal in the Jupyter app (**File → New → Terminal**) and choose one of the options below.

You will need access to LUMI and are a member of a LUMI computing project. 

1. Create a personal folder:
```
mkdir -p /scratch/$PROJECT/$USER
```

2. Clong the demo repository to your working directory:
```
git clone https://github.com/ngnmai02/visual-anomaly-detection-demo.git
```

Then open the notebooks from `/scratch/$PROJECT/$USER/visual-anomaly-detection-demo` in the Jupyter file browser.

You can go through the files and scripts in the repository. 

We will start with `demo.ipynb`.

-----
**Acknowledgements**

The instruction for using Jupyter notebook on LUMI is based on [lumi-ai-factory/health-llm-finetune-demo](https://github.com/lumi-ai-factory/health-llm-finetune-demo/blob/main/notebooks/README.md).