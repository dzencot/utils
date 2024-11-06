#!/bin/bash

SOURCE_PATH=$1
COMMIT_NAME=$2

CURPATH=$(pwd)
REPO_PATHS=$(ls $SOURCE_PATH)
total=$(echo "$REPO_PATHS" | wc -l)
count=0

for i in $REPO_PATHS; do
  count=$((count+1))
  echo "============================================================================================"
  echo "repo $count/$total"
  echo $i
  cd $SOURCE_PATH/$i

  git add .
  git commit -m "$COMMIT_NAME"

  git pull --rebase --autostash

  git push

  sleep 2
done
