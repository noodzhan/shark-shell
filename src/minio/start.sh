#!/usr/bin/env bash

export MINIO_ROOT_USER=yapai
export MINIO_ROOT_PASSWORD=ypkj@1234
export MINIO_VOLUMES="/opt/minio/data"
export MINIO_OPTS="--console-address ":9001""
/usr/local/bin/minio server $MINIO_OPTS $MINIO_VOLUMES