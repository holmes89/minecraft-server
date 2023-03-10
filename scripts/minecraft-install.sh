#!/bin/bash

set -e, -u, -x, -o pipefail

sudo apt update -y
sudo apt install curl wget unzip grep screen openssl -y
wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2_amd64.deb -O libssl1.1.deb
sudo dpkg -i libssl1.1.deb
rm libssl1.1.deb
sudo useradd -m mcserver

sudo mkdir -p /home/mcserver/minecraft_bedrock
DOWNLOAD_URL=$(curl -H "Accept-Encoding: identity" -H "Accept-Language: en" -s -L -A "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; BEDROCK-UPDATER)" https://minecraft.net/en-us/download/server/bedrock/ |  grep -o 'https://minecraft.azureedge.net/bin-linux/[^"]*')
sudo wget $DOWNLOAD_URL -O /home/mcserver/minecraft_bedrock/bedrock-server.zip
sudo unzip /home/mcserver/minecraft_bedrock/bedrock-server.zip -d /home/mcserver/minecraft_bedrock/
sudo rm /home/mcserver/minecraft_bedrock/bedrock-server.zip
sudo chown -R mcserver: /home/mcserver/
sudo cp /tmp/server.properties /home/mcserver/minecraft_bedrock/server.properties
