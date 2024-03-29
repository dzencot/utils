#!/bin/bash

function join { local IFS="$1"; shift; echo "$*"; }

COURSES_PATH="/home/ivan/projects/hexlet/hexlet-exercise-kit/courses/en"
CURPATH=$(pwd)

COURSES=$(ls ${COURSES_PATH})
COURSES=(${COURSES/ / })

for COURSE_NAME in "${COURSES[@]}"; do
  LESSON_COUNTER=0
  # Скрипт принимает путь к директории курса, где нужно пофиксить имена
  # COURSE=$1
  COURSE="${COURSES_PATH}/${COURSE_NAME}"
  cd $COURSE
  git reset --hard
  git pull

  LESSONS=$(ls -d -v ${COURSE}/*/)
  LESSONS=(${LESSONS/ / })

  LESSON_NAME=(${LESSONS[-1]//// })
  LESSON_NAME=${LESSON_NAME[-1]}
  LESSON_COUNTER=(${LESSON_NAME//-/ })
  LESSON_COUNTER=$(expr $LESSON_COUNTER + 0)

  if [[ "$LESSON_COUNTER" -lt 1000 ]]; then
    echo PASS
    continue
  fi

  echo ${COURSE} >> ${CURPATH}/result.txt

  LESSONS_LENGTH=${#LESSONS[@]}

  COUNTER=$((900/${LESSONS_LENGTH}))

  ITER=0

  echo ${COUNTER}

  for CURRENT_LESSON in "${LESSONS[@]}"; do
    ITER=$((${ITER}+${COUNTER}))
    CURRENT_LESSON_NAME_DATA=(${CURRENT_LESSON//// })
    CURRENT_LESSON_DIR_NAME=${CURRENT_LESSON_NAME_DATA[-1]}
    CURRENT_LESSON_DIR_NAME_DATA=(${CURRENT_LESSON_DIR_NAME//-/ })
    
    CURRENT_LESSON_DIR_NAME_DATA[0]=${ITER}
    NEW_NAME=$(join "-" ${CURRENT_LESSON_DIR_NAME_DATA[@]})
    CURRENT_LESSON_NAME_DATA[-1]=${NEW_NAME}
    CURRENT_LESSON_NEW_NAME="/$(join "/" ${CURRENT_LESSON_NAME_DATA[@]})"
    echo ${CURRENT_LESSON} "->" ${CURRENT_LESSON_NEW_NAME}
    mv ${CURRENT_LESSON} ${CURRENT_LESSON_NEW_NAME}
  done

  git add .
  git commit -m'fix lessons prefix'
  git push

  echo ------------------------------END-----------------------------------
done
