import json

def lambda_handler(event, context):
    # ここに本当に行いたい処理を書きます
<<<<<<< HEAD
    print("本日は晴天なり。今日の日にちは、2024年6月です。私はAWS LambdaでPythonを使って、Glueジョブを実行するためのコードを書きたいです。")
    
    return {
        'statusCode': 200,
        'body': json.dumps('test glue')
=======
    print("こんばんは、世界！")
    
    return {
        'statusCode': 200,
        'body': json.dumps('今日は8月27日です。テストです')
>>>>>>> ab98b04a6fc1c208e08ae2df1c70a09af652d686
    }