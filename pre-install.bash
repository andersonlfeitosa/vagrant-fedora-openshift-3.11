#!/usr/bin/env bash

# # upgrading OS
dnf update -y -x kernel-*
dnf install -y docker git vim curl dos2unix zip unzip bash-completion

# docker vagrant user
groupadd docker
usermod -aG docker vagrant

# docker service
systemctl enable docker
systemctl start docker

# install okd
wget -P /home/vagrant https://github.com/openshift/origin/releases/download/v3.11.0/openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit.tar.gz
tar -xvzf /home/vagrant/openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit.tar.gz
mv /home/vagrant/openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit/oc /usr/bin
rm -rf /home/vagrant/openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit /home/vagrant/openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit.tar.gz
cat <<EOF >> /etc/docker/daemon.json
{
  "insecure-registries" : ["172.30.0.0/16"]
}
EOF

systemctl restart docker

cat <<EOF >> /usr/bin/start-oc
#!/bin/bash
oc cluster up --public-hostname=192.168.33.10
EOF

cat <<EOF >> /usr/bin/stop-oc
#!/bin/bash
oc cluster down
EOF

chmod 755 /usr/bin/start-oc /usr/bin/stop-oc
