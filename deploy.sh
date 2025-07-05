#!/bin/bash
set -euox pipefail

APIGW_ARN=$(aws ssm get-parameter --name "/cftest/apigw_arn" --query "Parameter.Value" --output text)

STAGE_NAME=$(aws ssm get-parameter --name "/cftest/apigw_stage_name" --query "Parameter.Value" --output text)

aws apigateway create-deployment --rest-api-id $APIGW_ARN --stage-name $STAGE_NAME
