# create-root-ca.sh
mkdir -p root-ca/certs   # New Certificates issued are stored here
mkdir -p root-ca/db      # Openssl managed database
mkdir -p root-ca/private # Private key dir for the CA

chmod 700 root-ca/private
touch root-ca/db/index

# Give our root-ca a unique identifier
openssl rand -hex 16 > root-ca/db/serial

# Create the certificate signing request
openssl req -new \
  -config root-ca/root-ca.conf \
  -out root-ca.csr \
  -keyout root-ca/private/root-ca.key

# Sign our request
openssl ca -selfsign \
  -config root-ca.conf \
  -in root-ca.csr \
  -out root-ca.crt \
  -extensions ca_ext