#!/bin/sh

HOSTNAME_GROUP=tmp.pri-1.example.com


## Auto-config

INSTANCE=$(wget -q -O - http://169.254.169.254/latest/meta-data/instance-id)
PRIVATE_DNS=$(wget -q -O - http://169.254.169.254/latest/meta-data/local-hostname)

HOSTNAME="$INSTANCE.$HOSTNAME_GROUP"


## Hostname

echo "$HOSTNAME" > /etc/hostname

sed -i '/^127.0.1.1/d' /etc/hosts
echo "127.0.1.1       $HOSTNAME $INSTANCE" >> /etc/hosts

service hostname restart


## Packages

apt-get update
apt-get upgrade -y


## DNS

apt-get install -y awscli

export AWS_ACCESS_KEY_ID="AWS_ACCESS_KEY_ID"
export AWS_SECRET_ACCESS_KEY="AWS_SECRET_ACCESS_KEY"

ROUTE53_HOSTED_ZONE_ID="ROUTE53_HOSTED_ZONE_ID"
ROUTE53_DNS_TTL=300
ROUTE53_BATCH_JSON="{\"Changes\":[{\"Action\":\"CREATE\",\"ResourceRecordSet\":{\"Name\":\"$HOSTNAME\",\"Type\":\"CNAME\",\"TTL\":$ROUTE53_DNS_TTL,\"ResourceRecords\":[{\"Value\":\"$PRIVATE_DNS\"}]}}]}"

aws route53 change-resource-record-sets --hosted-zone-id "$ROUTE53_HOSTED_ZONE_ID" --change-batch "$ROUTE53_BATCH_JSON"

## Puppet

apt-get install -y puppet

PUPPET_MASTER=puppet.pri-1.example.com

puppet agent --enable
puppet agent --server "$PUPPET_MASTER" --test --waitforcert 5 # distro puppet
cp -R /var/lib/puppet/ssl/ /etc/puppet/ # maintain certs through upgrade
puppet agent --test # upgraded puppet