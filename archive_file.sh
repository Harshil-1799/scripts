#!/bin/bash

# Variables
BASE=/home/admin1/Videos/Screencasts
DAYS=10
DEPTH=1
RUN=0

# Check if the directory is present or not
if [ ! -d "$BASE" ]; then
    echo "Directory does not exist: $BASE"
    exit 1
fi

# Create "Archive" folder if not present
if [ ! -d "$BASE/archive" ]; then
    mkdir "$BASE/archive"
fi

# Find the list of files larger than 5MB and older than 10 days
find "$BASE" -maxdepth "$DEPTH" -type f \( -size +5M -o -mtime +"$DAYS" \) | while IFS= read -r i; do
    if [ "$RUN" -eq 0 ]; then
        echo "[$(date "+%Y-%m-%d:%M:%S")] archiving $i ==> $BASE/archive"
        gzip "$i" || exit 1
        mv "$i.gz" "$BASE/archive" || exit
    fi
done
