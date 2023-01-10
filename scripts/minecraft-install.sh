#!/bin/bash

# set -e, -u, -x, -o pipefail

apt update -y
apt install curl wget unzip grep screen openssl -y
wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2_amd64.deb -O libssl1.1.deb
dpkg -i libssl1.1.deb
rm libssl1.1.deb
useradd -m mcserver

mkdir -p /home/mcserver/minecraft_bedrock
DOWNLOAD_URL=$(curl -H "Accept-Encoding: identity" -H "Accept-Language: en" -s -L -A "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; BEDROCK-UPDATER)" https://minecraft.net/en-us/download/server/bedrock/ |  grep -o 'https://minecraft.azureedge.net/bin-linux/[^"]*')
wget $DOWNLOAD_URL -O /home/mcserver/minecraft_bedrock/bedrock-server.zip
unzip /home/mcserver/minecraft_bedrock/bedrock-server.zip -d /home/mcserver/minecraft_bedrock/
rm /home/mcserver/minecraft_bedrock/bedrock-server.zip
chown -R mcserver: /home/mcserver/
# cp server.properties /home/mcserver/minecraft_bedrock/server.properties