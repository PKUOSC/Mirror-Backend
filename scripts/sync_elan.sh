#!/usr/bin/env bash
set -eu -o pipefail

declare -a all_stores=(\
  "/data/repos/elan/releases"    \
  "/datahdd/repos/elan/releases" \
)
all_stores_len=${#all_stores[@]}

for (( i=0; i<${all_stores_len}; i++ )); do
  mkdir -p ${all_stores[$i]}
done

latest_release=$(curl -sSfL https://api.github.com/repos/leanprover/elan/releases/latest)
latest_assets=$(echo "$latest_release" | jq -r '.assets[] | select(.name | endswith(".tar.gz") or endswith(".zip")) | .name')
latest_name=$(echo "$latest_release" | jq -r '.name')

base_url="https://github.com/leanprover/elan/releases/download/$latest_name"

for asset in $latest_assets; do
  url="$base_url/$asset"

  temp_file=$(mktemp)
  curl -sSfL "$url" -o "$temp_file"

  for (( j=0; j<${all_stores_len}; j++ )); do
    store=${all_stores[$j]}
    cp "$temp_file" "$store/$asset"
  done

  rm "$temp_file"
done
