# GraphCodeBERT Replication for Code Translation

Work done by Team SAPlings: Siddharth Gandhi, Arjun Choudhary, and Piyush Khanna for the purposes of 11711 ANLP assignment 3 for Fall 2023 @ CMU.

This repo contains the code for our replication model of GraphCodeBERT for code translation task. The original paper can be found [here](https://arxiv.org/abs/2009.08366).


## Setup
Create a conda environment with the following command:
```bash
conda create -n anlp_hw3 python=3.9 -y
conda activate anlp_hw3
```

Install the required packages:
```bash
pip install -r requirements.txt
```

 Trained models, and checkpoints are available at [this link](https://drive.google.com/drive/folders/1nn0U9PWPzOAFZQgLh7MOcFhqO2w8PUce?usp=sharing) for both C# to Java and Java to C# translation tasks. Download the trained models from Google Drive.
```bash
bash download_models.sh
```

Download and setup necessary files for the parser:
```bash
cd parser
bash build.sh
cd ..
cp parser/ evaluation/CodeBLEU/ -r
```

## Data
We are using the data provided by the GraphCodeBERT authors. The data can be downloaded from [here](https://github.com/microsoft/CodeBERT/tree/master/GraphCodeBERT/translation). We have already stored the train, val and test data files in the [data/java-cs](data/java-cs) folder.

For our custom evaluation we have handpicked 31 examples from Leetcode with versions in both C# and Java. The data can be found in the [data/exps](data/exps) folder.



## Usage

### Training
To train the model, run the following command:
```bash
bash run_training.sh
```

Each of the 2 models (Java2C# and C#2Java) was trained on 2 A6000 Gpus for 100 epochs which took about 4.2 hours. The trained models are available in the Google Drive link above.

### Replication

We replicate the results on the test set by running the following command:
```bash
bash inference.sh
```

The results for the replication are available in available at the following links for [C# to Java](data/cs-java/replication_results) and [Java to C#](data/java-cs/replication_results).

### Custom Evaluation
To evaluate the model on our custom dataset, run the following command:
```bash
bash run_exps.sh
```

We also have micro_experiments available in the [data/exps](data/exps) folder. These look at results specific to just parts of the custom dataset like just easy questions or questions without multiple functions in the answer. The results for these experiments are available in the [data/exps/micro_exps_results](data/exps/micro_exps_results) folder.

For each experiments, the gold file, the predicted output file and metrics file is available in the [data](data) folder. We evaluate them using BLEU, CodeBLEU, Exact Match, among other metrics.
