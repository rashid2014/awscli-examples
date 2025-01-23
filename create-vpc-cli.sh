#Create a VPC 10.20.0.0/16
aws ec2 create-vpc \
    --cidr-block 10.20.0.0/16

VPC: vpc-0c28296492dbe96b9

#Create an IGW and Attach the IGW to the VPC
aws ec2 create-internet-gateway \
    --tag-specifications 'ResourceType=internet-gateway,Tags=[{Key=Name,Value=my-igw}]'

IGW: igw-06f5a99654575cc83

aws ec2 attach-internet-gateway \
    --internet-gateway-id igw-06f5a99654575cc83 \
    --vpc-id vpc-0c28296492dbe96b9

#Create a Public RT and attach Route with 0.0.0.0/0, IGW
aws ec2 create-route-table --vpc-id vpc-0c28296492dbe96b9

RouteTable: rtb-0768a891c28301c93

aws ec2 create-route \
    --route-table-id rtb-0768a891c28301c93 \
    --destination-cidr-block 0.0.0.0/0 \
    --gateway-id igw-06f5a99654575cc83

#create 2 Subnets
#Subnet1: CIDR: 10.20.1.0/24, AZ: ca-central-1a
#Subnet2: CIDR: 10.20.2.0/24, AZ: ca-central-1b

aws ec2 create-subnet \
    --vpc-id vpc-0c28296492dbe96b9 \
    --cidr-block 10.20.1.0/24 \
    --availability-zone ca-central-1a \
    --tag-specifications 'ResourceType=subnet,Tags=[{Key=Name,Value=PublicSubnet1}]'

aws ec2 create-subnet \
    --vpc-id vpc-0c28296492dbe96b9 \
    --cidr-block 10.20.2.0/24 \
    --availability-zone ca-central-1b \
    --tag-specifications 'ResourceType=subnet,Tags=[{Key=Name,Value=PublicSubnet2}]'

Subnet1ID: subnet-0e4abf8c581ea794e
Subnet2ID: subnet-0bfbc95e5caa9f7d9

#Associate both subnets to PublicRT

aws ec2 associate-route-table \
    --route-table-id rtb-0768a891c28301c93 \
    --subnet-id subnet-0e4abf8c581ea794e

aws ec2 associate-route-table \
    --route-table-id rtb-0768a891c28301c93 \
    --subnet-id subnet-0bfbc95e5caa9f7d9

#Modify Subnet Settins to enable auto-assign public IP
aws ec2 modify-subnet-attribute \
    --subnet-id subnet-0e4abf8c581ea794e \
    --map-public-ip-on-launch

aws ec2 modify-subnet-attribute \
    --subnet-id subnet-0bfbc95e5caa9f7d9 \
    --map-public-ip-on-launch

#Create a EC2-SG, with 80, 22 allow for 0.0.0.0/0
aws ec2 create-security-group \
    --group-name my-sg \
    --description "My security group" \
    --vpc-id vpc-0c28296492dbe96b9 \
    --tag-specifications 'ResourceType=security-group,Tags=[{Key=Name,Value=my-sg}]'

SG-ID: sg-0ab4cc3b5b57fb59f


#Create an EC2 with Subnet1ID, SG-ID, AMI-ID:

aws ec2 run-instances \
    --image-id ami-0956b8dc6ddc445ec \
    --count 1 \
    --instance-type t2.micro \
    --associate-public-ip-address \
    --key-name metrocanadakp \
    --security-group-ids sg-0ab4cc3b5b57fb59f \
    --subnet-id subnet-0e4abf8c581ea794e \
    --region ca-central-1

EC2: i-0b6e35459beb4b47e



