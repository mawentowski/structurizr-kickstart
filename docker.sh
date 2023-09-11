#!/bin/bash

source .env
source .env.user

WORKSPACE_PATH=workspaces/${WORKSPACE}:${CONTAINER_PATH}/workspaces/

docker_cmd="docker run -it --rm -p ${HOST_PORT}:8080 -v ${LOCAL_PATH}/workspaces/${WORKSPACE}:${CONTAINER_PATH} ${IMAGE_NAME}"

echo "Running Docker command:"
echo "${docker_cmd}"

$docker_cmd
