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

for x in $(find -type f -regex ".*\.md" -printf '%P\n'); do
  cmark $x > ${OUTPUT_DIR}/${x/.md/.html}
done
