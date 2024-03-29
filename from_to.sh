#!/bin/bash

source .env

# TOKEN= #gitlab token
API_URL=https://gitlab.hexlet.io/api/v4/projects
OLD_BRANCH=master
NEW_BRANCH=main
NAMESPACE=hexlethq/exercises/en

SOURCE_PATH=$1
DESTINATION_PATH=$2
NAMESPACE_ID=$3

if [ -z "$NAMESPACE_ID" ]
then
  echo "Group id is empty"
  exit 1
fi

CURPATH=$(pwd)
REPO_PATHS=$(ls $SOURCE_PATH)
total=$(echo "$REPO_PATHS" | wc -l)
count=0

mkdir -p $DESTINATION_PATH

for i in $REPO_PATHS; do
  count=$((count+1))
  echo "============================================================================================"
  echo "repo $count/$total"
  echo $i
  CURRENT_EXERCISE_PATH=$SOURCE_PATH/$i

  cd $CURRENT_EXERCISE_PATH

  echo Current exercise path: $CURRENT_EXERCISE_PATH

  git reset --hard
  git clean -df

  git checkout main
  git pull --rebase --autostash

  cp $CURRENT_EXERCISE_PATH $DESTINATION_PATH/$i -r

  echo "curl -s --request POST --header \"PRIVATE-TOKEN: $TOKEN\" --url \"$API_URL?name=$i&namespace_id=$NAMESPACE_ID\""
  response=$(curl -s --request POST --header "PRIVATE-TOKEN: $TOKEN" --url "$API_URL?name=$i&namespace_id=$NAMESPACE_ID")
  url=$(echo "$response" | jq -r '.ssh_url_to_repo')
  echo URL: $url

  cd $DESTINATION_PATH/$i

  git remote set-url origin $url
  git push -u origin --all
  git push -u origin --tags

  sleep 2
done
