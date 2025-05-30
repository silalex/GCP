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

