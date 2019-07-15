#!/bin/bash
set -eu -o pipefail

#Installing pakcage wrk
sudo apt-get install build-essential libssl-dev git -y
git clone https://github.com/wg/wrk.git wrk
cd wrk
make
# move the executable to somewhere in your PATH, ex:
sudo cp wrk /usr/local/bin

# install build deps
add-apt-repository ppa:ethereum/ethereum
apt-get update
#apt-get install -y build-essential unzip libdb-dev libsodium-dev zlib1g-dev libtinfo-dev solc sysvbanner wrk
apt-get install -y build-essential unzip libdb-dev libleveldb-dev libsodium-dev zlib1g-dev libtinfo-dev solc sysvbanner software-properties-common default-jdk maven

# install constellation
#wget -q https://github.com/jpmorganchase/constellation/releases/download/v0.1.0/constellation-0.3.2-ubuntu1604.tar.xz
#tar -xf constellation-0.3.2-ubuntu1604.tar.xz
#cp constellation-0.3.2-ubuntu1604/constellation-node /usr/local/bin
#chmod 0755 /usr/local/bin/constellation-node
#rm -rf constellation-0.3.2-ubuntu1604*

# install constellation
CVER="0.3.2"
CREL="constellation-$CVER-ubuntu1604"
wget -q https://github.com/jpmorganchase/constellation/releases/download/v$CVER/$CREL.tar.xz
tar xfJ ${CREL}.tar.xz
cp ${CREL}/constellation-node /usr/local/bin && chmod 0755 /usr/local/bin/constellation-node
rm -rf ${CREL}

# install golang
GOREL=go1.7.3.linux-amd64.tar.gz
wget -q https://storage.googleapis.com/golang/$GOREL
tar xfz $GOREL
mv go /usr/local/go
rm -f $GOREL
PATH=$PATH:/usr/local/go/bin
echo 'PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc

# make/installing quorum
git clone https://github.com/jpmorganchase/quorum.git
pushd quorum >/dev/null
make all
cp build/bin/geth /usr/local/bin
cp build/bin/bootnode /usr/local/bin
popd >/dev/null

# done!
banner "Quorum"
