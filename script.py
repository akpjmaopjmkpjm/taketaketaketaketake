import json

def lambda_handler(event, context):
    # ここに本当に行いたい処理を書きます
    print("こんばんは、世界！")
    
    return {
        'statusCode': 200,
        'body': json.dumps('今日は8月27日です。')
    }