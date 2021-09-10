#!/bin/sh
cd /home
sudo apt update
sudo apt upgrade
sudo apt install libssl1.0-dev nodejs-dev node-gyp nodejs
sudo apt install git build-essential cmake libuv1-dev libssl-dev libhwloc-dev
sudo apt install npm
npm install pm2@latest -g
sudo apt-get install -y libpci-dev

git clone https://github.com/xmrig/xmrig.git
mkdir xmrig/build
cd xmrig/build
cmake ..
make -j$(nproc)

sudo cp xmrig /usr/bin
cd /home

wget https://phoenixminer.info/downloads/PhoenixMiner_5.7b_Linux.tar.gz
tar -xvzf PhoenixMiner_5.7b_Linux.tar.gz
cd PhoenixMiner_5.7b_Linux
sudo cp PhoenixMiner /usr/bin
cd /home

clear

echo "Enter GPU Miner Name"
read gpuminername
pm2 start --name=gpuminer "PhoenixMiner -pool ethash.unmineable.com:3333 -wal DOGE:DPBLj6Uwj4sUkXqazU3s7iuVaerQi22oRR.$gpuminername -pass x"

echo "Enter CPU Miner Name"
read cpuminername
pm2 start --name=cpuminer "xmrig -o stratum+tcp://rx.unmineable.com:3333 -a rx -k --threads=2 -u DOGE:DPBLj6Uwj4sUkXqazU3s7iuVaerQi22oRR.$cpuminername -p x"

clear
pm2 logs