// 1) clone Git-repo
git clone https://github.com/GoogleCloudPlatform/training-data-analyst
cd /home/jupyter/training-data-analyst/quests/dataflow_python/

# Change directory into the lab
cd 5_Streaming_Analytics/lab
export BASE_DIR=$(pwd)

// 2) Setting up dependencies
python3 -m pip install -q --upgrade pip setuptools wheel
python3 -m pip install apache-beam[gcp]

// 3) Ensure that the Dataflow API is enabled:
gcloud services enable dataflow.googleapis.com

// 4) grant the dataflow.worker role to the Compute Engine default service account:
PROJECT_ID=$(gcloud config get-value project)
export PROJECT_NUMBER=$(gcloud projects list --filter="$PROJECT_ID" --format="value(PROJECT_NUMBER)")
export serviceAccount=""$PROJECT_NUMBER"-compute@developer.gserviceaccount.com"

### In the Cloud Console, navigate to IAM & ADMIN > IAM, click on Edit principal icon for Compute Engine default service account.
### Add Dataflow Worker as another role and click Save.

// 5) Set up the data environment
# Create GCS buckets and BQ dataset
cd $BASE_DIR/../..
source create_streaming_sinks.sh

# Change to the directory containing the practice version of the code
cd $BASE_DIR


// 6) Run the pipeline
export PROJECT_ID=$(gcloud config get-value project)
export REGION='us-central1'
export BUCKET=gs://${PROJECT_ID}
export PIPELINE_FOLDER=${BUCKET}
export RUNNER=DataflowRunner
export PUBSUB_TOPIC=projects/${PROJECT_ID}/topics/my_topic
export WINDOW_DURATION=60
export AGGREGATE_TABLE_NAME=${PROJECT_ID}:logs.windowed_traffic
export RAW_TABLE_NAME=${PROJECT_ID}:logs.raw


python3 streaming_minute_traffic_pipeline.py \
--project=${PROJECT_ID} \
--region=${REGION} \
--staging_location=${PIPELINE_FOLDER}/staging \
--temp_location=${PIPELINE_FOLDER}/temp \
--runner=${RUNNER} \
--input_topic=${PUBSUB_TOPIC} \
--window_duration=${WINDOW_DURATION} \
--agg_table_name=${AGGREGATE_TABLE_NAME} \
--raw_table_name=${RAW_TABLE_NAME}

// 7) Monitor the pipeline
# Open the Dataflow console to monitor the pipeline OR use the command below
gcloud dataflow jobs list --project=${PROJECT_ID} --region=${REGION}

// 8) Generate lag-less streaming input
bash generate_streaming_events.sh

// 9) Examine the results in BigQuery
SELECT timestamp, page_views
FROM `logs.windowed_traffic`
ORDER BY timestamp ASC

# Alternatively, you can use the BigQuery command-line tool 
# as a quick way to confirm results are being written:
bq head logs.raw
bq head logs.windowed_traffic


