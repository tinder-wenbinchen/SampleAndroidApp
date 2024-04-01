#!/bin/bash

echo "Starting calculating strings job"
git status
# switch to main branch
git fetch origin master
result=$(git diff --name-only origin/master HEAD | grep '\values/strings.xml')
fileArr=($result)
stringsNeedTranslation=()
i=0
for file in ${fileArr[*]}
do
  stringsNeedTranslation[i]=$(git diff -U0 origin/master HEAD ${file} | grep '^\+[[:space:]]*<string name=' | grep -Ev '^(--- a/|\+\+\+ b/)')
  i=$((i+1))
done
echo "::set-output name=updatedStrings::${stringsNeedTranslation[@]}"