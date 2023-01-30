import json
import boto3
import botocore

s3 = boto3.resource('s3')

def lambda_handler(event, context):
    result_list = []
    for bucket in s3.buckets.all():
        result_list.append(bucket.name)
    return {
        'statusCode': 200,
        'body': json.dumps(result_list)
    }