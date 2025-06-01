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