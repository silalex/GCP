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



