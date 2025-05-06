#!/bin/bash

SOURCE_PATH=$1
DESTINATION_FILE_PATH=$2

REGEXP='(?<=(\"languageToolLinter\.languageTool\.ignoredWordsInWorkspace\"\: \[))(\s|\S)*(?=\]\n\})'

grep -r '$REGEXP' $SOURCE_PATH > $DESTINATION_FILE_PATH
