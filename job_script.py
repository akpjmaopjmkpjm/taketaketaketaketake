import sys
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext

# GlueContext の初期化
sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session

print("=== Glue Job Script Started ===")

# 単純な DataFrame を作ってログに出す
df = spark.createDataFrame(
    [
        ("na-", 1),
        ("deploy-test", 2)
    ],
    ["name", "value"]
)

df.show()

print("=== Glue Job Script Finished ===")