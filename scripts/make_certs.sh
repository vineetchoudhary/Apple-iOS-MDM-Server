#!/bin/sh

echo ""
echo "1. Signing the identity key with the CA."
echo " ** Create an export passphrase. You'll need to include it in the MDM profile."
echo ""
openssl x509 -req -days 365 -in identity.csr -CA cacert.crt -CAkey cakey.key -CAcreateserial -out identity.crt
openssl pkcs12 -export -out identity.p12 -inkey identity.key -in identity.crt -certfile cacert.crt
cat server.crt server.key > server.pem


echo ""
echo "2. Copying keys and certs to server folder"
# Move relevant certs to the /server/ directory
mv server.key ../server/server.key
mv server.crt ../server/server.crt
mv server.pem ../server/server.pem
mv cacert.crt ../server/ca.crt
mv identity.crt ../server/identity.crt
cp identity.p12 ../server/Identity.p12