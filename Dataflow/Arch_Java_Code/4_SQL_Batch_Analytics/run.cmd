// 1) Prepare environment
# Change directory into the lab
cd 4_SQL_Batch_Analytics/labs

# Download dependencies
mvn clean dependency:resolve
export BASE_DIR=$(pwd)


// 2) Set up the data environment:
# Create GCS buckets and BQ dataset
cd $BASE_DIR/../..
source create_batch_sinks.sh

# Generate event dataflow
source generate_batch_events.sh

# Change to the directory containing the practice version of the code
cd $BASE_DIR


// 3) Ensure that the Data Catalog APIs is enabled:
gcloud services enable datacatalog.googleapis.com


// 4) ownload the dependencies through maven
mvn clean dependency:resolve


// 5) Run the Dataflow pipeline
# Set up environment variables
export PROJECT_ID=$(gcloud config get-value project)
export REGION='us-central1'
export BUCKET=gs://${PROJECT_ID}
export PIPELINE_FOLDER=${BUCKET}
export MAIN_CLASS_NAME=com.mypackage.pipeline.BatchUserTrafficSQLPipeline
export RUNNER=DataflowRunner
export INPUT_PATH=${PIPELINE_FOLDER}/events.json
export AGGREGATE_TABLE_NAME=${PROJECT_ID}:logs.user_traffic
export RAW_TABLE_NAME=${PROJECT_ID}:logs.raw

cd $BASE_DIR
mvn compile exec:java \
-Dexec.mainClass=${MAIN_CLASS_NAME} \
-Dexec.cleanupDaemonThreads=false \
-Dexec.args=" \
--project=${PROJECT_ID} \
--region=${REGION} \
--stagingLocation=${PIPELINE_FOLDER}/staging \
--tempLocation=${PIPELINE_FOLDER}/temp \
--runner=${RUNNER} \
--inputPath=${INPUT_PATH} \
--aggregateTableName=${AGGREGATE_TABLE_NAME} \
--rawTableName=${RAW_TABLE_NAME}"