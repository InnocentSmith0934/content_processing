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

# Determine header text based on presence of css file
# If there is a css file, put it in a css directory and link it
if [ -f style.css ]
then
  mkdir ${OUTPUT_DIR}/css
  cp style.css ${OUTPUT_DIR}/css/
  read -d '' HEADER << EOF
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="/css/style.css">
</head>
<body>
EOF
else
  read -d '' HEADER << EOF
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
EOF
fi
read -d '' FOOTER << EOF
</body>
</html>
EOF

for x in $(find -type f -regex ".*\.md" -printf '%P\n'); do
  FILE=${OUTPUT_DIR}/${x/.md/.html}
  echo "$HEADER" > $FILE
  cmark $x >> $FILE
  echo "$FOOTER" >> $FILE
done
