#!/bin/bash

source .env

echo "key ${TOKEN}"
# TOKEN= #gitlab token
API_URL=https://gitlab.com/api/v4/projects
OLD_BRANCH=master
NEW_BRANCH=main
NAMESPACE=hexlethq/exercises/en

SOURCE_PATH=$1
DESTINATION_PATH=$2
NAMESPACE_ID=$3

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
  CURRENT_EXERCICE_PATH=$SOURCE_PATH/$i

  cd $CURRENT_EXERCICE_PATH

  git checkout main
  git pull

  cp $CURRENT_EXERCICE_PATH $DESTINATION_PATH/$i -r

  response=$(curl -s --request POST --header "PRIVATE-TOKEN: $TOKEN" --url "$API_URL?name=$i&namespace_id=$NAMESPACE_ID")
  url=$(echo "$response" | jq -r '.ssh_url_to_repo')
  echo URL: $url

  git remote rename origin old-origin
  git remote add origin $url
  git push -u origin --all
  git push -u origin --tags

  sleep 2
done
