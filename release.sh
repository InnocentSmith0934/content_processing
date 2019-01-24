#! /bin/bash

process_md.sh .bundle
tar -czf bundle.tar.gz -C .bundle .

if [ $# == 1 ]
then
  INSTANCE=$1
  scp bundle.tar.gz ${INSTANCE}:~
elif [ $# == 2 ]
then
  INSTANCE=$1
  DEPLOY_DIR=$2
  scp bundle.tar.gz ${INSTANCE}:~
  ssh $INSTANCE "rm -rf ${DEPLOY_DIR}/*; tar -xzf bundle.tar.gz -C $DEPLOY_DIR"
fi
