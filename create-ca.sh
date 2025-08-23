# create-root-ca.sh
mkdir -p root-ca/certs   # New Certificates issued are stored here
mkdir -p root-ca/db      # Openssl managed database
mkdir -p root-ca/private # Private key dir for the CA
mkdir -p root-ca/clients # Client certificates issued are stored here
chmod 700 root-ca/private
chmod 700 root-ca/clients
touch root-ca/db/index

# CA Certificate

# Give our root-ca a unique identifier
openssl rand -hex 16 > root-ca/db/serial

openssl genpkey -out root-ca/private/root-ca.key \
  -algorithm RSA \
  -pkeyopt rsa_keygen_bits:2048

# create the certificate signing request
openssl req -new \
  -config root-ca/root-ca.conf \
  -key root-ca/private/root-ca.key \
  -out root-ca/private/root-ca.csr

# Sign our request
openssl ca -selfsign \
  -config root-ca/root-ca.conf \
  -in root-ca/private/root-ca.csr \
  -out root-ca/private/root-ca.crt \
  -extensions ca_ext

# End Entity Certificate

# Copy out the certificate in PEM format
openssl x509 -in root-ca/private/root-ca.crt -out root-ca/certs/root-ca.pem -outform PEM

# Creating an end-entity certificate

openssl genpkey -out root-ca/clients/client.key \
  -algorithm RSA \
  -pkeyopt rsa_keygen_bits:2048

openssl req -new \
   -config root-ca/client-ca.conf \
   -key root-ca/clients/client.key \
   -out root-ca/clients/client.csr

openssl ca \
  -config root-ca/root-ca.conf \
  -in root-ca/clients/client.csr \
  -out root-ca/clients/client.crt \
  -extensions client_ext  

# Finally copy the client key and crt to ~/.ssh for use with AWS IAM Anywhere
cp root-ca/clients/client.key ~/.ssh/iam-roles-anywhere-demo.key
cp root-ca/clients/client.crt ~/.ssh/iam-roles-anywhere-demo.crt