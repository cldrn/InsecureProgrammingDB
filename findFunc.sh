#!/bin/bash

#pass three args db with functions, the path of the sorce code and the output path

input=$1 #file with the list of functions
sourceCodePATH=$2 #locate of the source code
output=$3 # output path

echo -e "This is an archive of dangerous programming functions known for causing security vulnerabilities in software\n" >> "$output/results.txt"
while IFS= read -r line
do
	echo -e "\n########### $line ###########\n" >> "$output/results.txt"
  	find "$sourceCodePATH" -type f -exec grep -wnH "$line" {} \; |tee -a "$output/results.txt"
  	echo -e "\n" >> "$output/$results.txt"
done < "$input"