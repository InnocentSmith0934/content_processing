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
  <title>The Timeline Project</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="/css/style.css">
</head>
<body>
EOF
fi
read -d '' FOOTER << EOF
</body>
<footer>
<div id="footer_kayfabe"><p>&copy; 2122-25 The Centennial Foundation. All rights reserved, except where limited by the laws of the Hundred Worlds.</p><p>The Centennial Foundation was chartered in 2118 by the Trans-Lunar Treaty Organization (in cooperation with participating TLTO member nations, city-states, and self-governing zones), the Office of the Trade Representative of the Hundred Worlds, and the L3 Priory of the Ardán to preserve historically significant documents recording the first century of human-Stellan contact. The charter of the Centennial Foundation guarantees its complete editorial independence and academic freedom.</p></div>
<div id="footer_real">Actually &copy; Copyright 2019 Kevin White. No aliens were consulted in the creation of these documents.</div>
</footer>
</html>
EOF

for x in $(find -type f -regex ".*\.md" -printf '%P\n'); do
  FILE=${OUTPUT_DIR}/${x/.md/.html}
  echo "$HEADER" > $FILE
  cmark $x >> $FILE
  echo "$FOOTER" >> $FILE
done
