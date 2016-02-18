#!/bin/bash

if [ "$#" -le 0 ]
then
  echo "Please specify username and hdfs dfs command arguments (or only a user for help)"
  exit 123
fi

HDFS_USERNAME=$1

shift

HDFS_DFS_COMMAND=$@

echo "user = " $HDFS_USERNAME
echo "hdfs dfs command = " $@

: ${HADOOP_PREFIX:=/usr/local/hadoop}

$HADOOP_PREFIX/etc/hadoop/hadoop-env.sh

# rm /tmp/*.pid

# installing libraries if any - (resource urls added comma separated to the ACP system variable)
# cd $HADOOP_PREFIX/share/hadoop/common ; for cp in ${ACP//,/ }; do  echo == $cp; curl -LO $cp ; done; cd -

# altering the core-site configuration
# sed s/HOSTNAME/$HOSTNAME/ /usr/local/hadoop/etc/hadoop/core-site.xml.template > /usr/local/hadoop/etc/hadoop/core-site.xml

echo "adding configuration from /config.tar.gz"
cd /usr/local/hadoop/etc/hadoop/
tar zxf /config.tar.gz ./core-site.xml ./hdfs-site.xml

#service sshd start
#$HADOOP_PREFIX/sbin/start-dfs.sh
#$HADOOP_PREFIX/sbin/start-yarn.sh

adduser $HDFS_USERNAME

su --preserve-environment --command "$HADOOP_PREFIX/bin/hdfs dfs $HDFS_DFS_COMMAND" $HDFS_USERNAME
