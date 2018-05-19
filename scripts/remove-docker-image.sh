#!/bin/bash
if [[ "$(docker images -q $image_name 2> /dev/null)" != "" ]]; then
  docker rmi -f $(docker images --format {{.ID}} $image_name)
fi
