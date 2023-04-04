#!/bin/bash

# Init
repo="$1"
ignore_branch_workflows=$2

if [[ -z $ignore_branch_workflows ]]; then
  ignore_branch_workflows=false
  echo "ignore_branch_workflows: $ignore_branch_workflows"
fi

if [[ $ignore_branch_workflows = true ]]; then
  files=$(ls -1 .github/workflows/ | sed  's/^/and .path != \".github\/workflows\//;s/$/\"/')
else
  files=""
fi

last_week=$(date -d "$date -1 weeks" +%s)
runs="repos/$repo/actions/runs"
query=".workflow_runs[] \
| select( \
.path != \".github/workflows/placeholder.yaml\" \
"$files"
)
| (.id)"
output=$(gh api --paginate $runs --jq "$query")

echo "housekeeping_output=$(echo $output)" >> $GITHUB_OUTPUT
