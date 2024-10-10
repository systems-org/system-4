#!/bin/bash

# Step 1: Find files in 'dataset1' containing the word 'sample'
# Step 2: For each file, count occurrences of 'CSC510', filter those with >= 3 occurrences
# Step 3: Sort the files by CSC510 count (descending) and by file size as a tiebreaker
# Step 4: Replace 'file_' with 'filtered_' in the file names and display the result

grep -rl "sample" dataset1/ | while read -r file; do
    # Count occurrences of 'CSC510' in the file
    csc510_count=$(grep -o "CSC510" "$file" | wc -l)

    # If there are 3 or more occurrences, print the file with its count
    if [ "$csc510_count" -ge 3 ]; then
        # Get the file size in bytes
        file_size=$(stat -c%s "$file")
        
        # Print the file, its CSC510 count, and its size
        echo "$csc510_count $file_size $file"
    fi
done | sort -k1,1nr -k2,2n | while read -r csc510_count file_size file; do
    # Replace 'file_' with 'filtered_' in the file name and print the final result
    echo "${file/dataset1\/file_/filtered_}"
done

