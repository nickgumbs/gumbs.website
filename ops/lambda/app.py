import json
import boto3
import os
import random

dynamodb = boto3.resource('dynamodb')
jokes_table = dynamodb.Table(os.environ['JOKES_TABLE'])
visitors_table = dynamodb.Table(os.environ['VISITORS_TABLE'])

CORS_HEADERS = {
    'Access-Control-Allow-Headers': '*',
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': '*'
}


def get_joke():
    size_item = jokes_table.get_item(Key={'week': 0})
    number = random.randint(1, int(size_item['Item']['size']))
    response = jokes_table.get_item(Key={'week': number})
    return json.dumps({number: str(response['Item']['joke'])}, ensure_ascii=False)


def record_visit():
    response = visitors_table.update_item(
        Key={'URL': 'gumbs.me'},
        UpdateExpression='SET numVisits = if_not_exists(numVisits, :start) + :inc',
        ExpressionAttributeValues={':inc': 1, ':start': 0},
        ReturnValues='UPDATED_NEW'
    )
    return json.dumps({'gumbs.me': int(response['Attributes']['numVisits'])})


def lambda_handler(event, context):
    path = event.get('path', '')
    if path == '/jokes':
        body = get_joke()
    elif path == '/visit':
        body = record_visit()
    else:
        return {
            'statusCode': 404,
            'headers': CORS_HEADERS,
            'body': json.dumps({'error': 'Not found'})
        }
    return {
        'isBase64Encoded': False,
        'statusCode': 200,
        'headers': CORS_HEADERS,
        'body': body
    }
