// 1) clone Git-repository
git clone https://github.com/GoogleCloudPlatform/training-data-analyst
cd /home/jupyter/training-data-analyst/quests/dataflow_python/

// 2) create a virtual environment
sudo apt-get update && sudo apt-get install -y python3-venv
python3 -m venv df-env

// 3) Install required packages 
python3 -m pip install -q --upgrade pip setuptools wheel
python3 -m pip install apache-beam[gcp]

// 4) Finally, ensure that the Dataflow API is enabled
gcloud services enable dataflow.googleapis.com

// 5) Generate syntethic data
export BASE_DIR=/home/jupyter/training-data-analyst/quests/dataflow_python/1_Basic_ETL/lab
cd $BASE_DIR/../..
source create_batch_sinks.sh
bash generate_batch_events.sh
head events.json

// 6) modify 'my_pipeline.py' file with final code