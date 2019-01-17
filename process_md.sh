#! /bin/bash

if [ $# == 0 ]
then
  OUTPUT_DIR=__output
elif [ $# == 1 ]
then
  OUTPUT_DIR=$1
fi

if [ -d $OUTPUT_DIR ]
then
  rm -rf $OUTPUT_DIR
fi

for x in $(find -type f -regex ".*\.md" -printf '%h\n'); do
  mkdir -p "${OUTPUT_DIR}${x/./}"
done

if [ -f style.css ]
then
  mkdir ${OUTPUT_DIR}/css
  cp style.css ${OUTPUT_DIR}/css/
  read -d '' HEADER << EOF
<!DOCTYPE html>
<html lang="en">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<head>
  <link rel="stylesheet" href="/css/style.css">
</head>
<body>
EOF
else
  read -d '' HEADER << EOF
<!DOCTYPE html>
<html lang="en">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<body>
EOF
fi

for x in $(find -type f -regex ".*\.md" -printf '%P\n'); do
  FILE=${OUTPUT_DIR}/${x/.md/.html}
  echo "$HEADER" > $FILE
  cmark $x >> $FILE
  echo "</body>" >> $FILE
done
