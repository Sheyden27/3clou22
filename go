#!/usr/bin/env bash

usage="$0 ip : connect to remote ssh server, not recording public key"

if (( $# < 1 ))
then
   echo "$usage"
   exit 1
fi

public_ip=$1

ssh -i ~/.ssh/id_rsa_jp \
    -o StrictHostKeyChecking=no \
    -o UserKnownHostsFile=/dev/null \
    root@${public_ip}

