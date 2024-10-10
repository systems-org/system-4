#!/bin/bash

input_file="titanic.csv"
output_file="titanic_filled.csv"

# Filling missing values and handling commas in Name field
awk -F',' 'BEGIN {OFS=","}
{
    
    for (i=1; i<=NF; i++) {
        gsub(/^"|"$/, "", $i) 
    }

    # Filling missing values in Embarked and Cabin fields
    if ($12 == "") $12 = "Unknown";   
    if ($11 == "") $11 = "N/A";
	    
    #part b) replacing male/female with m/f	    
    if ($6 == "male") $6 = "M";
    else if ($6 == "female") $6 = "F";

    # Filling missing age values with 0 
    # to simplify the average calculation
    if ($7 == "") $7 = "0";	    

    print $0;
}' "$input_file" > "$output_file"

#awk -F',' '($3 == "2") && ($13 ~ /^S|S/) {print $0}' "$output_file" 
#awk -F',' '($3 == "2") && ($13 ~ /^S|S/) {count++}
#END {print "Count:", count ? count : 0}' "$output_file"
#part a) and part c)
awk -F',' '($3 == "2") && ($13 ~ /^S|S/) {
    count++;
    total_age += $7;
}
END {
    avg_age = (count > 0) ? total_age / count : 0;
    print "Number of passengers who travelled 2nd class and embarked at Southampton:", count ? count : 0;
    print "Average Age of these passengers:", avg_age;
}' "$output_file"
