#!/bin/bash

# This script can be used to update the jars on the nodes or
# the class path script.

while getopts ?c:? OPTION
do
  case $OPTION in
      c)
        COMMAND=$OPTARG
          ;;
      ?)
          echo "You must use -c to specify the command."
          exit
          ;;
  esac
done

RUNCMD=/users/jlewi/git_cloud/gce/cluster_run_on_all_nodes.py

ContrailJar()
{
# Push the latest version of the contrail jar
python ${RUNCMD} \
    --pattern=spark.* \
    --command="echo hello" \
    --files=/mnt/users-disk/users/jlewi/git_cloud/spark/target/contrail-0.1-SNAPSHOT.jar  \
    --dest_dir=/usr/local/spark
}

ClassPath()
{
# Push the latest version of the classpath script
python ${RUNCMD}  --pattern=spark.* \
    --command="sudo cp -f /tmp/compute-classpath.sh /usr/local/spark/spark-0.9.1-bin-hadoop1/bin/compute-classpath.sh" \
    --files=/usr/local/spark/spark-0.9.1-bin-hadoop1/bin/compute-classpath.sh \
    --dest_dir=/tmp
}
${COMMAND}