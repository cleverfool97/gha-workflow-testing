#!/usr/bin/env bash
# pattern='\"777 ([^"]*)\"(.*)' this is for double quotes
pattern=''\''777 ([^'\'']*)'\''(.*)' # matches all strings with "'777 " as a prefix

mkdir exports
# for each file in the parameter
for file in "$@"; do
  echo "---------- $file is being processed ----------"
  # For each line in the file
  while IFS= read -r line
  do
    # Find all strings matching the pattern for the line, and add it to a list
    while [[ $line =~ $pattern ]]; do
      echo ${BASH_REMATCH[1]} >> exports/scrapedstrings.txt
      printf %s\\n "${BASH_REMATCH[1]}"
      line="${BASH_REMATCH[2]}"
    done
  done < "$file"
done