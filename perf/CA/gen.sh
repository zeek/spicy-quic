#!/bin/bash
set -eux
CANAME=perf-ca

openssl genrsa -out $CANAME.key 4096

openssl req -x509 -new -nodes -key $CANAME.key -sha256 -days 3650 -out $CANAME.crt \
    -subj '/CN=QUIC Perf Root CA/C=DE/ST=Lower Saxony/L=Hanover/O=Zeek.org' \

SERVERNAME=aioquic-server

openssl req -new -nodes -out $SERVERNAME.csr -newkey rsa:4096 -keyout $SERVERNAME.key -subj '/CN=AIO QUIC Server/C=DE/ST=Lower Saxony/L=Hanover/O=Zeek.org'

# create a v3 ext file for SAN properties
cat > $SERVERNAME.v3.ext << EOF
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names
[alt_names]
DNS.1 = localhost
DNS.2 = aioquic-server
IP.1 = 127.0.0.1
EOF

openssl x509 -req -in $SERVERNAME.csr -CA $CANAME.crt -CAkey $CANAME.key -CAcreateserial -out $SERVERNAME.crt -days 3650 -sha256 -extfile $SERVERNAME.v3.ext
