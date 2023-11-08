#!/bin/bash

# インターネット接続確認
$(curl -s -m 2 www.yahoo.co.jp) # | grep 'timed out')
if [ $? -ne '0' ]; then
    echo 'ERROR: internet not connected'
    exit 0
fi
echo 'OK:internet connected'

aws cloudformation describe-stacks --stack-name EC2TestStack --profile aws-user
