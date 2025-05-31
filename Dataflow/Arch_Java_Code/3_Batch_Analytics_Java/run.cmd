####################################################################
############# Part 1: Aggregating site traffic by user #############
####################################################################

// 1) Download dependencies
# Change directory into the lab
cd 3_Batch_Analytics/labs

# Download dependencies
mvn clean dependency:resolve
export BASE_DIR=$(pwd)


// 2) generate a source dataset
# Create GCS buckets and BQ dataset
cd $BASE_DIR/../..
source create_batch_sinks.sh

# Generate event dataflow
source generate_batch_events.sh

# Change to the directory containing the practice version of the code
cd $BASE_DIR


// 3) run the pipeline
export PROJECT_ID=$(gcloud config get-value project)
export REGION=us-east1
export BUCKET=gs://${PROJECT_ID}
export PIPELINE_FOLDER=${BUCKET}
export MAIN_CLASS_NAME=com.mypackage.pipeline.BatchUserTrafficPipeline
export RUNNER=DataflowRunner
export INPUT_PATH=${PIPELINE_FOLDER}/events.json
export TABLE_NAME=${PROJECT_ID}:logs.user_traffic

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
--tableName=${TABLE_NAME}"



####################################################################
############ Part 2: Aggregating site traffic by minute ############
####################################################################

// 1) add "origina" Java-code attached in the Task description

// 2) modify "original" Java-code according to the Task description

// 3) run the pipeline
export PROJECT_ID=$(gcloud config get-value project)
export REGION=us-east1
export BUCKET=gs://${PROJECT_ID}
export PIPELINE_FOLDER=${BUCKET}
export MAIN_CLASS_NAME=com.mypackage.pipeline.BatchMinuteTrafficPipeline
export RUNNER=DataflowRunner
export INPUT_PATH=${PIPELINE_FOLDER}/events.json
export TABLE_NAME=${PROJECT_ID}:logs.minute_traffic

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
--tableName=${TABLE_NAME}"
