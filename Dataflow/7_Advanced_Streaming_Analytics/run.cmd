// 1) clone Github-repo
git clone https://github.com/GoogleCloudPlatform/training-data-analyst
cd /home/jupyter/training-data-analyst/quests/dataflow_python/

// 2) Setting up virtual environment and dependencies
sudo apt-get update && sudo apt-get install -y python3-venv

## Create and activate virtual environment
python3 -m venv df-env
source df-env/bin/activate

// 3) install the packages you will need to execute your pipeline:
python3 -m pip install -q --upgrade pip setuptools wheel
python3 -m pip install apache-beam[gcp]

// 4) Ensure that the Dataflow API is enabled:
gcloud services enable dataflow.googleapis.com


// 5) Set up the data environment & source dataset generation:
# Create GCS buckets and BQ dataset
cd $BASE_DIR/../../
source create_streaming_sinks.sh

# Change to the directory containing the practice version of the code
cd $BASE_DIR


// 6) Run the Dataflow pipeline

export PROJECT_ID=$(gcloud config get-value project)
export REGION=europe-west1
export BUCKET=gs://${PROJECT_ID}
export PIPELINE_FOLDER=${BUCKET}
export RUNNER=DataflowRunner
export PUBSUB_TOPIC=projects/${PROJECT_ID}/topics/my_topic
export WINDOW_DURATION=60
export ALLOWED_LATENESS=1
export OUTPUT_TABLE_NAME=${PROJECT_ID}:logs.minute_traffic
export DEADLETTER_BUCKET=${BUCKET}

cd $BASE_DIR


python3 streaming_minute_traffic_pipeline.py \
--project=${PROJECT_ID} \
--region=${REGION} \
--staging_location=${PIPELINE_FOLDER}/staging \
--temp_location=${PIPELINE_FOLDER}/temp \
--runner=${RUNNER} \
--input_topic=${PUBSUB_TOPIC} \
--window_duration=${WINDOW_DURATION} \
--allowed_lateness=${ALLOWED_LATENESS} \
--table_name=${OUTPUT_TABLE_NAME} \
--dead_letter_bucket=${DEADLETTER_BUCKET} \
--allow_unsafe_triggers
