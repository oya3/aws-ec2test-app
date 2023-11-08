#!/bin/bash

# インターネット接続確認
$(curl -s -m 2 www.yahoo.co.jp) # | grep 'timed out')
if [ $? -ne '0' ]; then
    echo 'ERROR: internet not connected'
    exit 0
fi
echo 'OK:internet connected'

# 念のための接続先確認
read -p $'生成先は \e[33;41;1m AWS\e[m ? (y/N):' yn
case "$yn" in [yY]*) ;; *) echo "abort." ; exit ;; esac

echo '各awsサービス生成'
aws cloudformation create-stack --stack-name EC2TestStack --template-body file://ec2.yml  --parameters file://parameters.json --profile aws-user

