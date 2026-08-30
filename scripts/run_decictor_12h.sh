#!/bin/bash

project_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
# apollo checkout driven by these runs; override with APOLLO_ROOT=... bash <script>
apollo_root="${APOLLO_ROOT:-$(cd "${project_root}/../apollo-mozart-v7" && pwd)}"
method_name_list='decictor'
repeat_lst="1"
run_hour=12

declare -a seed_infos=(
    "scenario_1 sunnyvale_loop"
    "scenario_2 sunnyvale_loop"
    "scenario_3 sunnyvale_loop"
)

run_test() {
    run_id=$1
    seed_name=$2
    map_name=$3
    method_name=$4

    run_name=run_$run_id

    python ${project_root}/main_fuzzer.py \
      common.apollo_root="$apollo_root" \
      fuzzer=$method_name \
      fuzzer.run_hour=$run_hour \
      seed_name=$seed_name \
      map_name=$map_name \
      run_name="$run_name"
}

for run_id in $repeat_lst; do
  for seed_info in "${seed_infos[@]}"; do
    for method_name in $method_name_list; do
      IFS=' ' read -ra seed_details <<< "$seed_info"
      run_test "${run_id}" "${seed_details[0]}" "${seed_details[1]}" "${method_name}"
    done
  done
done
