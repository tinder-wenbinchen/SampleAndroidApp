#!/bin/bash

echo "Starting calculating strings job"
git status
# switch to main branch
git fetch origin master
git diff --name-only origin/master HEAD > diff_result
echo "Diff between branches: ${{ diff_result }}"