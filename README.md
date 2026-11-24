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

Open a terminal in the Jupyter app (**File → New → Terminal**).

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

### 4. Downloading dataset from LUMI-O

The dataset is available publicly on LUMI-O. 

You will first need to configure the rclone to retrieve the dataset.

1. Visit [lumi.csc.fi](https://www.lumi.csc.fi/public/) to retrieve the access key for LUMI-O. 

2. Select `LUMI-O Credential Management Service`and select the project you are currently using. 

3. Generate the access key and save `Access key` and `Secret key` somewhere safe and private. 

4. Going back to the Jupyter session and open a terminal in the Jupyter app (**File → New → Terminal**). Make sure you are in the root of this repository.
```
pwd
```

5. Set up rcond config for LUMI-O based on the instruction when running the below command. 
```
module load lumio
lumi-conf
```

6. Download the subset of Real-IAD from LUMI-O
```
mkdir dataset/
rclone copy lumi-462000131-public:realiad-demo-dataset/realiad_1024.zip dataset/
rclone copy lumi-462000131-public:realiad-demo-dataset/realiad_jsons_sv.zip dataset/
```

In the `demo.ipynb`, we will unzip the dataset and process it.

Let's start with `demo.ipynb`.


-----
**Acknowledgements**

The instruction for using Jupyter notebook on LUMI is based on [lumi-ai-factory/health-llm-finetune-demo](https://github.com/lumi-ai-factory/health-llm-finetune-demo/blob/main/notebooks/README.md).