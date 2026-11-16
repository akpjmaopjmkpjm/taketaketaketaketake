import json

def lambda_handler(event, context):
    # ここに本当に行いたい処理を書きます
    print("本日は晴天なり。今日の日にちは、2024年6月です。私はAWS LambdaでPythonを使って、Glueジョブを実行するためのコードを書きたいです。")
    
    return {
        'statusCode': 200,
        'body': json.dumps('test glue')
    }