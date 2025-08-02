ETL Processing on Google Cloud Using Dataflow and BigQuery [PWDW]

https://partner.cloudskillsboost.google/course_templates/399/labs/337220


Overview
In this lab, you will build several data pipelines that will ingest data from a publicly available dataset into BigQuery, using these Google Cloud services:
 - Cloud Storage
 - Dataflow
 - BigQuery tables

You will create your own data pipeline, including the design considerations, as well as implementation details, to ensure that your prototype meets the requirements. Be sure to open the Python files and read the comments when instructed to.


Step 1 - Data ingestion
You will now build a Dataflow pipeline with a TextIO source and a BigQueryIO destination to ingest data into BigQuery. More specifically, it will:
 - Ingest the files from Cloud Storage.
 - Filter out the header row in the files.
 - Convert the lines read to dictionary objects.
 - Output the rows to BigQuery.

2. Install pip package and latest Python SDK from PyPI:

sudo apt-get update
sudo apt-get -y install python3-pip

pip install apache-beam[gcp]

🔹 What does [gcp] mean?
The [gcp] is an "extra" dependency group defined in the apache-beam package. This installs additional libraries needed to run Beam pipelines on GCP, especially with the Dataflow runner.

It includes GCP-related packages such as:
 - google-cloud-core
 - google-cloud-storage
 - google-cloud-pubsub
 - google-cloud-bigquery
 - google-cloud-spanner

And others required for GCP connectors and IO transforms

Note: [gcp]	adds support for GCP IO (BigQuery, GCS, Pub/Sub, etc.) and the Dataflow runner


3. Run the Apache Beam pipeline

Enter the following command to run the pipeline. This will spin up the workers required, run the code and shut them down when complete:

'''
python3 data_ingestion.py \
  --project=$PROJECT_ID \
  --max_num_workers=2 \
  --runner=DataflowRunner \
  --region us-west1 \
  --staging_location=gs://$PROJECT_ID/test \
  --temp_location gs://$PROJECT_ID/test \
  --input gs://$PROJECT_ID/data_files/head_usa_names.csv \
  --save_main_session
'''

Note: 
  --runner=DataflowRunner	# Tells Apache Beam to run the job on Google Cloud Dataflow, not locally

Apache Beam is a unified programming model for batch and streaming data processing. You can run Beam pipelines on different runners, such as:
 - Google Cloud Dataflow (GCP): use "--runner=DataflowRunner" in the command line
 - Apache Flink
 - Apache Spark
 - DirectRunner (local testing): use "--runner=DirectRunner" in the command line



Step 2 - Data transformation

You will now build a Dataflow pipeline with a TextIO source and a BigQueryIO destination to ingest data into BigQuery. More specifically, you will:
 - Ingest the files from Cloud Storage.
 - Convert the lines read to dictionary objects.
 - Transform the data which contains the year to a format BigQuery understands as a date.
 - Output the rows to BigQuery.


Run the Apache Beam pipeline
You will run the Dataflow pipeline in the cloud. This will spin up the workers required, and shut them down when complete.

In the training-vm SSH terminal, run the following commands:
python3 data_transformation.py \
  --project=$PROJECT_ID \
  --max_num_workers=2 \
  --runner=DataflowRunner \
  --region us-west1 \
  --staging_location=gs://$PROJECT_ID/test \
  --temp_location gs://$PROJECT_ID/test \
  --input gs://$PROJECT_ID/data_files/head_usa_names.csv \
  --save_main_session



Step 3 - Data enrichment

You will now build a Dataflow pipeline with a TextIO source and a BigQueryIO destination to ingest data into BigQuery. More specifically, you will:
 - Ingest the files from Cloud Storage.
 - Filter out the header row in the files.
 - Convert the lines read to dictionary objects.
 - Output the rows to BigQuery.

Run the Apache Beam pipeline
Here you'll run the Dataflow pipeline in the cloud.

Run the following to spin up the workers required, and shut them down when complete:

python3 data_enrichment.py \
  --project=$PROJECT_ID \
  --max_num_workers=2 \
  --runner=DataflowRunner \
  --region us-west1 \
  --staging_location=gs://$PROJECT_ID/test \
  --temp_location gs://$PROJECT_ID/test \
  --input gs://$PROJECT_ID/data_files/head_usa_names.csv \
  --save_main_session