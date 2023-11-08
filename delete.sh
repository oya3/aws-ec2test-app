#!/bin/bash

# インターネット接続確認
$(curl -s -m 2 www.yahoo.co.jp) # | grep 'timed out')
if [ $? -ne '0' ]; then
    echo 'ERROR: internet not connected'
    exit 0
fi
echo 'OK:internet connected'

# 念のための接続先確認
read -p $'削除先は \e[33;41;1m AWS\e[m ? (y/N):' yn
case "$yn" in [yY]*) ;; *) echo "abort." ; exit ;; esac

aws cloudformation delete-stack --stack-name EC2TestStack --profile aws-user
