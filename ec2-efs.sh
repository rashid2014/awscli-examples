$ aws ec2 create-security-group \
--region ca-central-1 \
--group-name ec2-walkthrough1-efs-sg \
--description "Amazon EFS walkthrough 1, SG for EC2 instance" \
--vpc-id vpc-0d5d4b0f4e6f895ad

##...EFS-Lab....


$ aws ec2 create-security-group \
--region ca-central-1 \
--group-name efs-walkthrough1-ec2-sg \
--description "Amazon EFS walkthrough 1, SG for EC2 instance" \
--vpc-id vpc-0d5d4b0f4e6f895ad

$ aws ec2 create-security-group \
--region ca-central-1 \
--group-name efs-walkthrough1-mt-sg \
--description "Amazon EFS walkthrough 1, SG for mount target" \
--vpc-id vpc-0d5d4b0f4e6f895ad

SG-ID-1-EC2: sg-0900dede6bbbbcee8
SG-ID-2-EFS: sg-0e512c7d4a14a5a98

$ aws ec2 authorize-security-group-ingress \
--group-id sg-0900dede6bbbbcee8 \
--protocol tcp \
--port 22 \
--cidr 0.0.0.0/0 \
--region ca-central-1

$ aws ec2 authorize-security-group-ingress \
--group-id sg-0e512c7d4a14a5a98 \
--protocol tcp \
--port 2049 \
--source-group sg-0900dede6bbbbcee8 \
--region ca-central-1

$ aws ec2 authorize-security-group-ingress \
--group-id sg-0e512c7d4a14a5a98 \
--protocol tcp \
--port 2049 \
--source-group sg-0900dede6bbbbcee8 \
--region ca-central-1 


$ aws ec2 run-instances \
--image-id ami-0956b8dc6ddc445ec \
--count 1 \
--instance-type t2.micro \
--associate-public-ip-address \
--key-name metrocanadakp \
--security-group-ids sg-0900dede6bbbbcee8 \
--subnet-id subnet-05a218529c1a9dc62 \
--region ca-central-1

EC2-Instance-ID: i-0defef33cec34ded8
Subnet-ID-EC2: subnet-05a218529c1a9dc62

$ aws efs create-file-system \
--encrypted \
--creation-token FileSystemForWalkthrough1 \
--tags Key=Name,Value=SomeExampleNameValue \
--region ca-central-1

EFS-ID: fs-0df668d1b98bdea81
MountTarget-SG: sg-0e512c7d4a14a5a98

$ aws efs put-lifecycle-configuration \
--file-system-id fs-0df668d1b98bdea81 \
--lifecycle-policies TransitionToIA=AFTER_30_DAYS \
--region ca-central-1
          

$ aws efs create-mount-target \
--file-system-id fs-0df668d1b98bdea81 \
--subnet-id  subnet-05a218529c1a9dc62 \
--security-group sg-0e512c7d4a14a5a98 \
--region ca-central-1

EC2-DNS: ec2-35-183-180-194.ca-central-1.compute.amazonaws.com
EFS-DNS: fs-0df668d1b98bdea81.efs.ca-central-1.amazonaws.com


sudo mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport fs-0df668d1b98bdea81.efs.ca-central-1.amazonaws.com:/   ~/efs-mount-point