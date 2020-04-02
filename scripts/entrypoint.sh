#!/bin/bash
set -ex

./config --url "${RUNNER_REPO}" \
    --token "${RUNNER_TOKEN}" \
    --name "${RUNNER_NAME}" \
    --work /runner/_work

./run.sh
