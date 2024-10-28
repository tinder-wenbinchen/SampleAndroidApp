#!/bin/bash

# Get a list of files ending with strings.xml that are modified
# Initialize exitCode
exitCode=0
echo "base sha $GITHUB_BASE_SHA"
echo "head sha $GITHUB_HEAD_SHA"
modifiedStringsXmlFiles=$(git --no-pager diff --diff-filter=d --name-only "$GITHUB_BASE_SHA"..."$GITHUB_HEAD_SHA" | grep 'strings.xml$') || exitCode=$?

OUTPUT_A_VARIABLE="15.20.0"
# Output the milestone number to be captured by GitHub Actions
echo "output_a_variable=$OUTPUT_A_VARIABLE" >> $GITHUB_ENV

# Check if grep failed or the variable is empty
if [ "$exitCode" -eq 1 ] || [ -z "$modifiedStringsXmlFiles" ]; then
  echo "Exiting: No strings.xml changed"
  echo "strings_changed=false" >> "$GITHUB_OUTPUT"
else
  echo "strings.xml files have been changed."
  echo "strings_changed=true" >> "$GITHUB_OUTPUT"
fi
