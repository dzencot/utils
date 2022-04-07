#!/bin/bash

CURPATH=$(pwd)

FILE_PATHS=$(grep -iRl --include \*.yml '```sh' courses)

REPO_PATHS=$(echo "$FILE_PATHS" | cut -d / -f1,2,3 | uniq)

# echo "$REPO_PATHS"

for i in $REPO_PATHS; do
  echo $i
  cd $CURPATH/$i
  git pull
  # echo ""
done

echo "repos updated"

for i in $FILE_PATHS; do
  echo $i
  sed -i 's/```sh/```bash/' $CURPATH/$i
  # echo ""
done

echo "files changed"

for i in $REPO_PATHS; do
  echo $i
  cd $CURPATH/$i
  git commit -am 'use bash instead sh'
  git push || echo ""
  # echo ""
done

echo "repos pushed"
