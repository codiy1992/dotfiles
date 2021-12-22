#!/usr/bin/env bash

(($#)) || { echo 'Error: need image file path!'; exit 1;}

ORG_IMAGE="$1"
ORG_IMAGE_DIR=`dirname ${ORG_IMAGE}`
ASSET_PATH=~/Assets
IMAGE_DIR=${ORG_IMAGE_DIR#${ASSET_PATH}/}
TINY_DIR="${ASSET_PATH}/_optimized/${IMAGE_DIR}"

cd "$(cd "`dirname $0`"; pwd)"
mkdir -p ${TINY_DIR}
${PWD}/tinypng.sh -d ${TINY_DIR} -o -s -f "${ORG_IMAGE}"

rclone copy ${ORG_IMAGE} kfcs3:s3.codiy.net/${IMAGE_DIR}
rclone copy ${TINY_DIR}/${ORG_IMAGE##*/} kfcs3:s3.codiy.net/${TINY_DIR#${ASSET_PATH}/}
