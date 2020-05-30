#!/bin/bash
set -eu

benchmark_file="$1"_results.csv

touch "$1"_results.csv
echo "Number of function calls,InputRange(ms),OpApplyRange(ms)" > \
	$benchmark_file

func_calls=(10 100 1000 10000 100000 1000000 10000000 100000000 \
	1000000000 2000000000 4000000000)

ldc2 "$1"_array.d containers.d utils.d

for i in "${func_calls[@]}";
	do
		echo $i
		./"$1"_array "$i" >> $benchmark_file
done

