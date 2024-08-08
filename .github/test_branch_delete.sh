#!/bin/bash

# Get a list of files ending with strings.xml that are modified
# Initialize exitCode
exitCode=0
echo "base sha $GITHUB_BASE_SHA"
echo "head sha $GITHUB_HEAD_SHA"
modifiedStringsXmlFiles=$(git --no-pager diff --diff-filter=d --name-only "$GITHUB_BASE_SHA"..."$GITHUB_HEAD_SHA" | grep 'strings.xml$') || exitCode=$?

# Check if grep failed or the variable is empty
if [ "$exitCode" -eq 1 ] || [ -z "$modifiedStringsXmlFiles" ]; then
  echo "Exiting: No strings.xml changed"
  echo "strings_changed=false" >> "$GITHUB_OUTPUT"
else
  echo "strings.xml files have been changed."
  echo "strings_changed=true" >> "$GITHUB_OUTPUT"
fi