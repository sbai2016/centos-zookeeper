#!/bin/bash

# on démarre zookeeper
bash -c "/usr/hdp/current/zookeeper-server/bin/zkServer.sh start /etc/zookeeper/conf/zoo.cfg"

# on laisse le conteneur tourner
tail -f /dev/null
