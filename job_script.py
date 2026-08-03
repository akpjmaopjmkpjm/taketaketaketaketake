import sys
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext

# GlueContext の初期化
sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session

print("=== Glue Job Script Started ===")

# 単純な DataFrame を作成
df = spark.createDataFrame(
    [
        ("na-", 1),
        ("deploy-test", 2)
    ],
    ["name", "value"]
)

df.show()

# ★★★ ここで Glue の S3 に出力する ★★★
output_path = "s3://20260616-resi/output/"

df.write.mode("overwrite").json(output_path)

print(f"=== Data written to {output_path} ===")
print("=== Glue Job Script Finished ===")
