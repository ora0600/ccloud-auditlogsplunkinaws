#!/bin/bash
yum update -y
yum install wget -y
yum install unzip -y
sudo amazon-linux-extras install java-openjdk11
# install docker
yum install -y docker
# set environment
echo vm.max_map_count=262144 >> /etc/sysctl.conf
sysctl -w vm.max_map_count=262144
echo "    *       soft  nofile  65535
    *       hard  nofile  65535" >> /etc/security/limits.conf
sed -i -e 's/1024:4096/65536:65536/g' /etc/sysconfig/docker
# enable docker    
usermod -a -G docker ec2-user
service docker start
chkconfig docker on
curl -L https://github.com/docker/compose/releases/download/1.21.0/docker-compose-`uname -s`-`uname -m` | sudo tee /usr/local/bin/docker-compose > /dev/null
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# install Auditlog SPLUNK Demo
mkdir -p /home/ec2-user/software
chown ec2-user:ec2-user -R /home/ec2-user/software
cd /home/ec2-user/software
wget ${auditlogccloudsplunkdemo}
unzip main.zip
chown ec2-user:ec2-user -R /home/ec2-user/software/ccloudauditlogs_splunk-main/
rm main.zip
cd ccloudauditlogs_splunk-main/
touch env.sh
chown ec2-user:ec2-user -R *

export CONNECTOR_OWNER=${CONNECTOR_OWNER}
export CONNECTOR_NAME=${CONNECTOR_NAME}
export CONNECTOR_VERSION=${CONNECTOR_VERSION}
export BOOTSTRAP_SERVERS=${BOOTSTRAP_SERVERS}
export SASL_JAAS_CONFIG=${SASL_JAAS_CONFIG}


# print in env.sh
echo "export CONNECTOR_OWNER=$CONNECTOR_OWNER
export CONNECTOR_NAME=$CONNECTOR_NAME
export CONNECTOR_VERSION=$CONNECTOR_VERSION
export BOOTSTRAP_SERVERS=$BOOTSTRAP_SERVERS
export SASL_JAAS_CONFIG=$SASL_JAAS_CONFIG" >> /home/ec2-user/software/ccloudauditlogs_splunk-main/env.sh

source /home/ec2-user/software/ccloudauditlogs_splunk-main/env.sh
# build docker image
docker build \
    --build-arg CONNECTOR_OWNER=${CONNECTOR_OWNER} \
    --build-arg CONNECTOR_NAME=${CONNECTOR_NAME} \
    --build-arg CONNECTOR_VERSION=${CONNECTOR_VERSION} \
    -t localbuild/connect_standalone_with_${CONNECTOR_NAME}:${CONNECTOR_VERSION} \
    -f ./Docker-connect/standalone/Dockerfile ./Docker-connect/standalone

# docker-compose splunk Password1 change
NEWPASSWORD="SETYOURPASSWORDHERE"
cd /home/ec2-user/software/ccloudauditlogs_splunk-main/
SCRIPT="sed -i 's/SPLUNK_PASSWORD=Password1/SPLUNK_PASSWORD=$NEWPASSWORD/g' docker-compose.yml;"
# change ocker-compose file 
bash -c "$SCRIPT"

# Start environment
docker-compose up -d

# config bash_profile for ec2-user
echo "export PATH=/usr/local/bin:\$PATH" >> /home/ec2-user/.bash_profile
chown ec2-user:ec2-user /home/ec2-user/.bash_profile
echo "export PATH=/usr/local/bin:\$PATH" >> /root/.bash_profile
