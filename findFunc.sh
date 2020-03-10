#!/bin/bash

#pass three args db with functions, the path of the sorce code and the output path

#usage: ./findFunc.sh list/of/functions.txt /path/source/code/ /output/path

input=$1 #file with the list of functions
sourceCodePATH=$2 #locate of the source code
output=$3 # output path
timestamp=$(date +"%F-%T")

echo -e "This is an archive of dangerous programming functions known for causing security vulnerabilities in software\n $timestamp" >> "$output/results-$timestamp.txt"

while IFS= read -r line
do
	echo -e "\n########### $line ###########\n" >> "$output/results-$timestamp.txt"
  	find "$sourceCodePATH" -type f -exec grep -wnH "$line" {} \; |tee -a "$output/results-$timestamp.txt"
  	echo -e "\n" >> "$output/results-$timestamp.txt"
done < "$input"