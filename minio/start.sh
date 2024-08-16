#!/usr/bin/env bash

export MINIO_ROOT_USER=noodb
export MINIO_ROOT_PASSWORD=noodb@1234
export MINIO_VOLUMES="/opt/minio/data"
export MINIO_OPTS="--console-address ":9001""
/usr/local/bin/minio server $MINIO_OPTS $MINIO_VOLUMES