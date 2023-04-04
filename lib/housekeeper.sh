#!/bin/bash

# Init
repo="$2"
ignore_branch_workflows=$3

# GitHub auth
echo "$1" >auth.txt
gh auth login --with-token <auth.txt
if [[ $? -ne 0 ]]; then
  exit 1
fi

if [[ -z $ignore_branch_workflows ]]; then
  ignore_branch_workflows=false
  echo "ignore_branch_workflows: $ignore_branch_workflows"
fi

last_week=$(date -d "$date -1 weeks" +%s)
runs="repos/$repo/actions/runs"
files=$(ls -1 .github/workflows/ | sed  's/^/and .path != \".github\/workflows\//;s/$/\"/')
query=".workflow_runs[] \
| select( \
.path != \".github/workflows/placeholder.yaml\" \
"$files"
)
| select (.run_started_at | . == null or fromdateiso8601 < $last_week)
| (.id)"
gh api --paginate $runs --jq "$query" \
| xargs -n1 -I % gh api $runs/%
