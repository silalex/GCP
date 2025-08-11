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

