#!/usr/bin/env bash

# copie le script sur l'instance

usage="$0 ip script : copie le script sur l'instance"

if (( $# < 2 ))
then
  echo $usage
  exit 1
fi

script=$2
ip=$1

scp -i ~/.ssh/id_rsa_jp $script root@$ip:

