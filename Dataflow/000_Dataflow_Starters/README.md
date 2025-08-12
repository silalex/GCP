# Serverless Data Analysis with Dataflow - Lab 2 : MapReduce in Dataflow (Python) v1.3 #

https://partner.cloudskillsboost.google/course_templates/6/labs/12613


1) Clone github repo:
git clone https://github.com/GoogleCloudPlatform/training-data-analyst

2) Upgrade packages and install Apache Beam:
cd training-data-analyst/courses/data_analysis/lab2/python
python3 -m pip install apache-beam[gcp]

##############################################################################
# Note: 
#  In the Cloud Shell code editor navigate to the directory
#  ./training-data-analyst/courses/data_analysis/lab2/python and view the file 
#  is_popular.py in the Cloud Shell editor. Do not make any changes to the code.
##############################################################################
cd ~/training-data-analyst/courses/data_analysis/lab2/python
nano is_popular.py

3) Run the pipeline locally:
cd ~/training-data-analyst/courses/data_analysis/lab2/python
python3 ./is_popular.py

4) Check the output
cat /tmp/output-*

5) Change the output prefix from the default value:
python3 ./is_popular.py --output_prefix=/tmp/myoutput

6) Check the new output
cat /tmp/myoutput-*







# Serverless Data Analysis with Dataflow - Lab 2 : MapReduce in Dataflow (Java) v1.3 #

https://partner.cloudskillsboost.google/course_templates/6/labs/12614

1) Clone github repo:
git clone https://github.com/GoogleCloudPlatform/training-data-analyst

2) In the Cloud Shell code editor navigate to the directory /training-data-analyst/courses/data_analysis/lab2/javahelp/src/main/java/com/google/cloud/training/dataanalyst/javahelp and view the file IsPopular.java in the Cloud Shell editor. Do not make any changes to the code.

cd ~/training-data-analyst/courses/data_analysis/lab2/javahelp/src/main/java/com/google/cloud/training/dataanalyst/javahelp
nano IsPopular.java

3) Run the pipeline locally:
<!-- cd ~/training-data-analyst/courses/data_analysis/lab2/javahelp
mvn compile exec:java -Dexec.mainClass=com.google.cloud.training.dataanalyst.javahelp.IsPopular -->

export PATH=/usr/lib/jvm/java-8-openjdk-amd64/bin/:$PATH
cd ~/training-data-analyst/courses/data_analysis/lab2/javahelp
mvn compile -e exec:java \
 -Dexec.mainClass=com.google.cloud.training.dataanalyst.javahelp.IsPopular

4) Examine the output file:
cat /tmp/output.csv

5) Change the output prefix from the default value:
mvn compile -e exec:java \
  -Dexec.mainClass=com.google.cloud.training.dataanalyst.javahelp.IsPopular \
 -Dexec.args="--outputPrefix=/tmp/myoutput"

6) And check the changes:
ls -lrt /tmp/*.csv







# Serverless Data Analysis with Dataflow - Lab 3 : Side Inputs (Python) v1.3 #

https://partner.cloudskillsboost.google/course_templates/6/labs/12617

1) Clone github repo:
git clone https://github.com/GoogleCloudPlatform/training-data-analyst

2) In Cloud Shell, enter the following to create an environment variable named "BUCKET" and verify that it exists with the echo command:

BUCKET=$(gcloud config get-value project)
echo $BUCKET

3) Verify environment variable for your Project ID
Cloud Shell creates a default environment variable that contains the current Project ID:

echo $DEVSHELL_PROJECT_ID

4) Verify that Apache Beam is installed on Cloud Shell
Return to Cloud Shell. Verify that Apache Beam is installed on Cloud Shell. If the Cloud Shell has timed out and was reconnected, it may have lost the in-memory components of Apache Beam. There is no harm in reinstalling. It will take the necessary steps.

cd ~/training-data-analyst/courses/data_analysis/lab2/python
sudo ./install_packages.sh

5) Explore the pipeline code:
cd ~/training-data-analyst/courses/data_analysis/lab2/python
nano JavaProjectsThatNeedHelp.py

6) Execute the pipeline:
cd ~/training-data-analyst/courses/data_analysis/lab2/python
python3 -m pip install apache-beam[gcp]

6) Execute the pipeline locally by typing the following into Cloud Shell:
python3 JavaProjectsThatNeedHelp.py --bucket $BUCKET --project $DEVSHELL_PROJECT_ID --region us-central1 --DirectRunner

7) Execute the pipeline on the cloud by typing the following into Cloud Shell:
python3 JavaProjectsThatNeedHelp.py --bucket $BUCKET --project $DEVSHELL_PROJECT_ID --region us-central1 --DataFlowRunner