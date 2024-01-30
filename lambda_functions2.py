import json

def lambda_handler(event, context):
    # Print the received event
    print("Received event: " + json.dumps(event, indent=2))

    # Business logic goes here

    return {
        'statusCode': 200,
        'body': json.dumps('Hello from your Lambda Function!')
    }