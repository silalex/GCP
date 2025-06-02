#################################################################################
### part 1: Performing unit tests for DoFns and PTransforms (batch pipelines) ###
#################################################################################

// 1) Prepare environment (Setting up virtual environment and dependencies)
# Change directory into the lab
cd 8a_Batch_Testing_Pipeline/lab
export BASE_DIR=$(pwd)

# create a virtual environment
sudo apt-get install -y python3-venv

# Create and activate virtual environment
python3 -m venv df-env

source df-env/bin/activate

# install the packages you will need to execute your pipeline:
python3 -m pip install -q --upgrade pip setuptools wheel
python3 -m pip install apache-beam[gcp]


// 2) Ensure that the Dataflow API is enabled:
gcloud services enable dataflow.googleapis.com


// 3) create a storage bucket:
export PROJECT_ID=$(gcloud config get-value project)
gcloud storage buckets create gs://$PROJECT_ID --location=US



# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! #
#########  no Python code in the Github-repo (only JAVA) #########
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! #
