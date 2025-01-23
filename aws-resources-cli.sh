#Create a KMS Key in your region
aws kms create-key --region ca-central-1
aws kms create-alias --region ca-central-1 --target-key-id 03cb0119-2f2d-4296-926d-457ab82db59d --alias-name alias/my-s3-key


KMS-ARN: arn:aws:kms:ca-central-1:911167917923:key/03cb0119-2f2d-4296-926d-457ab82db59d
KMS-KeyID: 03cb0119-2f2d-4296-926d-457ab82db59d


#Create an S3 Bucket in your region using the above KMS Key
aws s3api create-bucket --bucket metrocjan222025 --region ca-central-1 --create-bucket-configuration LocationConstraint=ca-central-1 --acl private

S3-Bucket-ARN: http://metrocjan222025.s3.amazonaws.com
S3-Bucket-Name: metrocjan222025

#Add KMS Key to the bucket
aws s3api put-bucket-encryption --bucket metrocjan222025 --server-side-encryption-configuration '{"Rules": [{"ApplyServerSideEncryptionByDefault": {"SSEAlgorithm": "aws:kms", "KMSMasterKeyID": "03cb0119-2f2d-4296-926d-457ab82db59d"}}]}'

#Create an IAM Role, Trust: EC2, Permission: ManagedPolicyARN: arn:aws:iam::aws:policy/AmazonEC2FullAccess

IAM-Role-ARN: