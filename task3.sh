awk -F, '($3 == 2) && ($13 ~ /S/) {print}' titanic.csv | \
    sed -e 's/female/F/g' -e 's/male/M/g' | \
    tee >(cat >&2) | \
    awk -F, '$7 != "" { total_age += $7; num++ } END { if (num > 0) print "Average Age: " total_age/num }'
