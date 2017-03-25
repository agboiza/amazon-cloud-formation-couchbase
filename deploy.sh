#!/bin/sh

TEMPLATE_BODY=`cat ./cloud-formation-couchbase.json`
STACK_NAME=$1
REGION=`aws configure get region`

VPC=`aws ec2 describe-vpcs --filter Name="isDefault",Values="true" --output text | cut -f7`
NODE_COUNT="5"
INSTANCE_TYPE="m4.large"

aws cloudformation validate-template --template-body $TEMPLATE_BODY

aws cloudformation create-stack \
--template-body $TEMPLATE_BODY \
--stack-name $STACK_NAME \
--region $REGION \
--parameters \
ParameterKey=VPC,ParameterValue=$VPC \
ParameterKey=NodeCount,ParameterValue=$NODE_COUNT \
ParameterKey=InstanceType,ParameterValue=$INSTANCE_TYPE
