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

// 7) Run the pipeline localy to verify that it works
cd $BASE_DIR

# Set up environment variables
export PROJECT_ID=$(gcloud config get-value project)

# run the pipeline
python3 my_pipeline.py \
  --project=${PROJECT_ID} \
  --region=us-central1 \
  --stagingLocation=gs://$PROJECT_ID/staging/ \
  --tempLocation=gs://$PROJECT_ID/temp/ \
  --runner=DirectRunner

// 9) Run the pipeline on Dataflow

# Set up environment variables
cd $BASE_DIR
export PROJECT_ID=$(gcloud config get-value project)

# Run the pipelines
python3 my_pipeline.py \
  --project=${PROJECT_ID} \
  --region=us-central1 \
  --stagingLocation=gs://$PROJECT_ID/staging/ \
  --tempLocation=gs://$PROJECT_ID/temp/ \
  --runner=DataflowRunner



################ Part 2: Parameterizing basic ETL ####################

// 1) Create a JSON schema file & copy this file to Cloud Storage
bq show --schema --format=prettyjson logs.logs | sed '1s/^/{"BigQuery Schema":/' | sed '$s/$/}/' > schema.json

cat schema.json

export PROJECT_ID=$(gcloud config get-value project)
gcloud storage cp schema.json gs://${PROJECT_ID}/

// 2) Create a JavaScript user-defined function & copy it to Cloud Storage
cat <<EOF > transform.js
function transform(line) {
  return line;
}
EOF

export PROJECT_ID=$(gcloud config get-value project)
gcloud storage cp *.js gs://${PROJECT_ID}/


// 3) Run a Dataflow Template (manually in Google Cloud Console)