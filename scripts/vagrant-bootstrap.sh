#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

apt-get update -q
apt-get install -q -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" \
  postfix dnsmasq mutt vim

# Provide hostnames so the boxes can talk to each other. DNSMasq will also serve
# results to each box based on these contents.
cat >> /etc/hosts <<EOF
192.168.33.5 sender sender.example.com
192.168.33.7 valid valid-example-recipient.com
EOF

# All local domains get an MX record pointing at themselves
echo selfmx > /etc/dnsmasq.conf
# Not sure why restart is necessary, but otherwise dnsmasq doesn't use
# /etc/hosts to answer queries.
/etc/init.d/dnsmasq restart

# if [ "`hostname`" = "sender" ]; then
#   (while sleep 10; do
#     echo -e 'Subject: hi\n\nhi' | sendmail vagrant@valid-example-recipient.com
#    done) &
#   #ln -sf "/vagrant/postfix-config-sender-tls_policy.cf" /etc/postfix/tls_policy
# fi

#ln -sf "/vagrant/postfix-config-`hostname`.cf" /etc/postfix/main.cf
#ln -sf "/vagrant/certificates" /etc/certificates
postfix reload
