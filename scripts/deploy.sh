#!/bin/bash

TARGET_BUCKET="bucket-recive"
JOB_NAME="testglue-20260430"

echo "=== Glue Deploy Started ==="

aws s3 cp /opt/deploy/job_script.py \
s3://$TARGET_BUCKET/job_script.py

aws glue update-job \
  --job-name $JOB_NAME \
  --job-update file:///opt/deploy/job.json

echo "=== Glue Deploy Finished ==="