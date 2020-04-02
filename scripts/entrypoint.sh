#!/bin/bash
set -ex

export RUNNER_ALLOW_RUNASROOT=1

./config --url "${RUNNER_REPO}" \
    --token "${RUNNER_TOKEN}" \
    --name "${RUNNER_NAME}" \
    --work /runner/_work

./run.sh
