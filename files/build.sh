#!/bin/bash
sudo apt install golang
ver=1.1.2
wget https://github.com/grahamedgecombe/ct-submit/archive/v${ver}.zip
unzip v${ver}.zip
pushd ct-submit-${ver}
go build
mv ct-submit-${ver} ct-submit
echo "Submit X.509 certificate chans to Certificate Transparency log servers" > description-pak
sudo checkinstall -D --install=no --pkgname=ct-submit --pkgversion=${ver} --pkgrelease=1 -y --nodoc --strip=yes --backup cp ct-submit /usr/bin
mv *.deb ..
popd

