import json

def lambda_handler(event, context):
    # ここに本当に行いたい処理を書きます
    print("Hello from Lambda!")
    
    return {
        'statusCode': 200,
        'body': json.dumps('おはようございます。')
    }