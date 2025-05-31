// 1) clone Git-repo
git clone https://github.com/GoogleCloudPlatform/training-data-analyst
cd /home/jupyter/training-data-analyst/quests/dataflow_python/

// 2) Setting up virtual environment and dependencies
sudo apt-get update && sudo apt-get install -y python3-venv
python3 -m venv df-env
source df-env/bin/activate

// 3) install the packages you will need to execute your pipeline:
python3 -m pip install -q --upgrade pip setuptools wheel
python3 -m pip install apache-beam[gcp]

// 4) ensure that the Dataflow API is enabled:
gcloud services enable dataflow.googleapis.com

// 5) Set up the data environment
# Create GCS buckets and BQ dataset
cd $BASE_DIR/../..
source create_batch_sinks.sh

# Generate event dataflow
source generate_batch_events.sh

# Change to the directory containing the practice version of the code
cd $BASE_DIR



// 6) Run the Dataflow pipeline

# Set up environment variables
export PROJECT_ID=$(gcloud config get-value project)
export REGION=us-central1
export BUCKET=gs://${PROJECT_ID}
export COLDLINE_BUCKET=${BUCKET}-coldline
export PIPELINE_FOLDER=${BUCKET}
export RUNNER=DataflowRunner
export INPUT_PATH=${PIPELINE_FOLDER}/events.json
export OUTPUT_PATH=${PIPELINE_FOLDER}-coldline/pipeline_output
export TABLE_NAME=${PROJECT_ID}:logs.logs_filtered

cd $BASE_DIR
python3 my_pipeline.py \
--project=${PROJECT_ID} \
--region=${REGION} \
--stagingLocation=${PIPELINE_FOLDER}/staging \
--tempLocation=${PIPELINE_FOLDER}/temp \
--runner=${RUNNER} \
--inputPath=${INPUT_PATH} \
--outputPath=${OUTPUT_PATH} \
--tableName=${TABLE_NAME}



