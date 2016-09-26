#!/usr/bin/env bash

server=${1:-"test"}

openssl genrsa -des3 -out ${server}.key 1024
openssl req -config openssl.cnf -new -key ${server}.key -out ${server}.csr
cp ${server}.key ${server}.key.org
openssl rsa -in ${server}.key.org -out ${server}.key
openssl x509 -req -days 365 -in ${server}.csr -signkey ${server}.key -out ${server}.crt
