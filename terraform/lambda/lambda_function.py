import sys
import logging
import pymysql
import boto3
import json
import ast
import os

DB_HOST = os.getenv('DB_HOST')
DB_NAME = os.getenv('DB_NAME')
DB_PASSWORD=os.getenv('DB_PASSWORD')
DB_PORT = int(os.getenv('DB_PORT'))
DB_USERNAME = os.getenv('DB_USERNAME')
connection = pymysql.connect(
    host = DB_HOST,
    user = DB_USERNAME,
    passwd = DB_PASSWORD,
    db = 'ericdb',
    port = DB_PORT,
    ) # db 접근 하기 위한 정보 
def lambda_handler(event, context):
    eng_name=event["queryStringParameters"]["eng_name"]
    query =  "select korean_name from cds_people where english_name="+"'"+eng_name+"';"
    cursor = connection.cursor()
    cursor.execute(query)
    rows = cursor.fetchall() # 데이터를 DB로부터 가져온 후, Fetch 된 데이터를 사용
    if(len(rows)==0):
        res={"eng_name":"None"}
        return(res)
    cursor.close()
    res=rows[0][0]
    res={"eng_name":res}
    return({
        'statusCode':200,
        'body':json.dumps(res,ensure_ascii=False)
    })
 
