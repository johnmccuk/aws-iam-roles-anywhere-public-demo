import boto3

session = boto3.Session(profile_name='iam-anywhere')
dev_s3_client = session.client('s3')

def list_buckets():
    try:
        response = dev_s3_client.list_buckets()
        print("Buckets:")
        for bucket in response['Buckets']:
            print(f"  {bucket['Name']}")
    except Exception as e:
        print(f"Error listing buckets: {e}")

list_buckets()