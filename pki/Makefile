.PHONY: ca
CA = assets/ca-key.pem assets/ca.csr assets/ca.pem

ca: $(CA)

$(CA): ca-csr.json
	cfssl gencert -initca ca-csr.json | cfssljson -bare assets/ca
