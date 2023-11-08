# 使い方

以下の手順はすべて、ubuntu22.04 環境を想定している  

0. 準備：aws config の profile 設定は事前に設定しておくこと  
   各スクリプトの profile 設定は aws-user としてある  
   ※スタック名は EC2TestStack としている  
1. paramters.json に生成したいec2情報を設定  
   - MyAppName ... EC2インスタンス名  
   - MyInstanceType ... インスタンスタイプ(t3.microとか、、、)  
   - MyVolumeSize ... GB容量(EBS)
2. ./create.sh を実行  
   実行すると cloudformation に EC2TestStack というスタック作成され、paramters.json の内容に従って ec2 インスタンスが生成される  
3. 生成された EC2Test インスタンスのパブリック IPv4 アドレスを確認する  
   aws console にログインし、 ec2 から EC2Test インスタンスを選択し、パブリック IPv4 アドレスを確認する  
   ここでは 12.345.67.89 として説明する  
4. ssh 接続用の pem ファイルを取得する
   生成完了するとssh接続用の pem が生成されているので取得する  
   aws console にログインし、AWS Systems Manager (SSM) のパラメータストアから手動でダウンロード  
   （ssm 設定があれば aws cli で取得可能と思われる）  
   https://ap-northeast-1.console.aws.amazon.com/systems-manager  
   ここでは ~/.ssh/EC2Test.key.pem として保存する。
5. ssh 接続設定をホストOS(Ubuntu)にする  
   HostName は EC2Test インスタンスのパブリック IPv4 アドレス  
   User はデフォルトでubuntuらしい  
   ```bash
   $ chmod 600 ~/.ssh/EC2Test.key.pem
   $ emacs ~/.ssh/config
   Host EC2Test
     HostName 12.345.67.89
     Port 22
     User ubuntu
     IdentityFile ~/.ssh/EC2Test.key.pem
   ```
6. ssh 接続してec2環境を構築する  
   $ ssh EC2Test で接続できる。  
   また、ec2.yml の MyEC2Instance/Properties/UserData に実行したい手順を記載してもいい。（Dockerfile と同じ感じ）  

