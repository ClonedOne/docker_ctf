#!/bin/bash

if [ -z "$1" ]
  then
    echo "Specify the binary to pass to the container"
    exit 1
fi

binary_file=$1

docker build --build-arg binary=$binary_file -t ub_binaries .
