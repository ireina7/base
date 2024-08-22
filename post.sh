#!/bin/bash

date=$(date '+%Y-%m-%d')
summary=./src/SUMMARY.md

id=''
path=journal/$date
if [ "$2" ]; then
    id=$2
    path=$date-$2.md
else
    path=$date.md
fi

BLOG_FILE="./src/journal/$path"
touch $BLOG_FILE
echo "# $1" >> $BLOG_FILE

# sed "/^- \[Journal\]/s/$/ $1/" ./src/SUMMARY.md

IFS=''
cp $summary "${summary}.old"
cat "${summary}.old" | while read -r line ; do
    echo $line
    [[ $line == *"[Journal]"* ]] && echo "  - [$1](./journal/$path)"
done > $summary
rm -f "${summary}.old"

journal=./src/journal/journal.md

IFS=''
cp $journal "${journal}.old"
cat "${journal}.old" | while read -r line ; do
    echo $line
    [[ $line == "## 2"* ]] && echo "- [$1](./$path)"
done > $journal
rm -f "${journal}.old"
