#!/bin/bash

date=$(date '+%Y-%m-%d')
summary=./src/SUMMARY.md

id=''
path=journal/$date
if [ "$2" ]; then
    id=$2
    path=journal/$date-$2.md
else
    path=journal/$date.md
fi

BLOG_FILE="./src/$path"
touch $BLOG_FILE
echo "# $1" >> $BLOG_FILE

# sed "/^- \[Journal\]/s/$/ $1/" ./src/SUMMARY.md

IFS=''
cp $summary "${summary}.old"
cat "${summary}.old" | while read -r line ; do
    echo $line
    [[ $line == *"[Journal]"* ]] && echo "  - [$1](./$path)"
done > $summary

rm -f "${summary}.old"
