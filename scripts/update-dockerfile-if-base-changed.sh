#!/bin/bash
value=$(grep $TAG $PATH_TO_FILE)
if [ -z "$value" ]
then
  sed -i '' -e 's/FROM .*/FROM '"$TAG"'/' $PATH_TO_FILE
  echo ">>> updated base image in target Dockerfile to $TAG"
fi
