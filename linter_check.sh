#!/bin/bash

EXERCISE_KIT_PATH="/home/ivan/projects/hexlet/hexlet-exercise-kit"
LANGUAGE=$1

CURPATH=$(pwd)
COURSES=$(find "${EXERCISE_KIT_PATH}/exercises/en" -maxdepth 1 -regex ".*-${LANGUAGE}-.*")

TEST_RESULT='error'

echo '' > ${CURPATH}/result.txt

for COURSE in $COURSES; do
  REPO_PATHS=$(ls $COURSE)
  # echo $REPO_PATHS
  for REPO in $REPO_PATHS; do
    FULL_PATH="${COURSE}/${REPO}"
    echo ${FULL_PATH}
    cd ${FULL_PATH}
    make build
    make start
    TEST_OUTPUT=$(make lint-hexlet-js)
    if [[ ${TEST_OUTPUT} == *${TEST_RESULT}* ]]; then
      echo NOT OK
      echo ${FULL_PATH} >> ${CURPATH}/result.txt
    fi
  done
done
