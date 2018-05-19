#!/bin/bash
if [ -n "$AWS_PROFILE" ]; then
    PROFILE_FLAG="--profile $AWS_PROFILE"
fi
file="./profiles/$ENV.env"
if [ -f "$file" ]
then
  echo "$file is exist."
  echo "removing $ENV.env ... "
  rm ./profiles/$ENV.env
  echo "fetching $ENV.env from s3 ... "
  aws s3 cp s3://registry-credential/registry-core-services/$ENV.env ./profiles/$ENV.env --region us-east-1 $PROFILE_FLAG
  rm ./.env
  cp ./profiles/$ENV.env ./.env
else
	echo "$file not found."
  echo "fetching $ENV.env from s3 ... "
  aws s3 cp s3://registry-credential/registry-core-services/$ENV.env ./profiles/$ENV.env --region us-east-1 $PROFILE_FLAG
  rm ./.env
  cp ./profiles/$ENV.env ./.env
fi
