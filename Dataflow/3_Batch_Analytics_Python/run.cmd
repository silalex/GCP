##################################################################################
#####################  Part 1. Aggregating site traffic by user  #################
##################################################################################

// 1) Clone Github repo
git clone https://github.com/GoogleCloudPlatform/training-data-analyst
cd /home/jupyter/training-data-analyst/quests/dataflow_python/


// 2) Setting up virtual environment and dependencies
sudo apt-get update && sudo apt-get install -y python3-venv

# Create and activate virtual environment
python3 -m venv df-env
source df-env/bin/activate

# install the packages you will need to execute your pipeline:
python3 -m pip install -q --upgrade pip setuptools wheel
python3 -m pip install apache-beam[gcp]

# Ensure that the Dataflow API is enabled:
gcloud services enable dataflow.googleapis.com


// 3) Set up the data environment
# Create GCS buckets and BQ dataset
cd $BASE_DIR/../..
source create_batch_sinks.sh

# Generate event dataflow
source generate_batch_events.sh

# Change to the directory containing the practice version of the code
cd $BASE_DIR


// 4) modify "original" Python code according to the task requirements & run the pipeline

export PROJECT_ID=$(gcloud config get-value project)
export REGION=us-west1
export BUCKET=gs://${PROJECT_ID}
export PIPELINE_FOLDER=${BUCKET}
export RUNNER=DataflowRunner
export INPUT_PATH=${PIPELINE_FOLDER}/events.json
export TABLE_NAME=${PROJECT_ID}:logs.user_traffic

cd $BASE_DIR
python3 batch_user_traffic_pipeline.py \
--project=${PROJECT_ID} \
--region=${REGION} \
--staging_location=${PIPELINE_FOLDER}/staging \
--temp_location=${PIPELINE_FOLDER}/temp \
--runner=${RUNNER} \
--input_path=${INPUT_PATH} \
--table_name=${TABLE_NAME}



##################################################################################
##################### Part 2. Aggregating site traffic by minute #################
##################################################################################

// 1) modify "original" Python code according to the task requirements & run the pipeline

// 2) run the pipeline

export PROJECT_ID=$(gcloud config get-value project)
export REGION=us-west1
export BUCKET=gs://${PROJECT_ID}
export PIPELINE_FOLDER=${BUCKET}
export RUNNER=DataflowRunner
export INPUT_PATH=${PIPELINE_FOLDER}/events.json
export TABLE_NAME=${PROJECT_ID}:logs.minute_traffic

cd $BASE_DIR
python3 batch_minute_traffic_pipeline.py \
--project=${PROJECT_ID} \
--region=${REGION} \
--staging_location=${PIPELINE_FOLDER}/staging \
--temp_location=${PIPELINE_FOLDER}/temp \
--runner=${RUNNER} \
--input_path=${INPUT_PATH} \
--table_name=${TABLE_NAME}

