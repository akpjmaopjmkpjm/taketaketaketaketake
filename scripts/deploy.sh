#!/bin/bash
set -e

# S3 バケット名と Glue Job 名を設定
BUCKET_NAME="glue-script-bucket"
JOB_NAME="my-glue-job"

echo "=== Glue Deploy Started ==="

# Glue Script を S3 にアップロード
aws s3 cp /opt/deploy/job_script.py s3://$BUCKET_NAME/job_script.py

# Glue Job の設定を更新
aws glue update-job \
  --job-name $JOB_NAME \
  --job-update file:///opt/deploy/job.json

echo "=== Glue Deploy Finished ==="