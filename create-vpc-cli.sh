#Create a VPC 10.20.0.0/0

VPC: 

#Create an IGW and Attach the IGW to the VPC
IGW:

#Create a Public RT and attach Route with 0.0.0.0/0, IGW
RouteTable:

#create 2 Subnets
#Subnet1: CIDR: 10.20.1.0/24, AZ: ca-central-1a
#Subnet2: CIDR: 10.20.2.0/24, AZ: ca-central-1b
Subnet1ID:
Subnet2ID:

#Associate both subnets to PublicRT


#Create a EC2-SG, with 80, 22 allow for 0.0.0.0/0
SG-ID:


#Create an EC2 with Subnet1ID, SG-ID, AMI-ID:



