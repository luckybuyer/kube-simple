.PHONY: ca master worker all
CA = assets/ca-key.pem assets/ca.csr assets/ca.pem
MASTER = assets/master-key.pem assets/master.csr assets/master.pem
WORKER = assets/worker-key.pem assets/worker.csr assets/worker.pem
ADMIN = assets/admin-key.pem assets/admin.csr assets/admin.pem

all: master worker admin
ca: $(CA)
master: $(MASTER)
worker: $(WORKER)
admin: $(ADMIN)


$(CA): ca-csr.json
	cfssl gencert -initca ca-csr.json | cfssljson -bare assets/ca

$(MASTER): $(CA) kube-master.json ca-config.json
	cfssl gencert -ca=assets/ca.pem -ca-key=assets/ca-key.pem -config=ca-config.json -profile=server kube-master.json | cfssljson -bare assets/master

$(WORKER): $(CA) kube-worker.json ca-config.json
	cfssl gencert -ca=assets/ca.pem -ca-key=assets/ca-key.pem -config=ca-config.json -profile=client kube-worker.json | cfssljson -bare assets/worker

$(ADMIN): $(CA) kube-admin.json ca-config.json
	cfssl gencert -ca=assets/ca.pem -ca-key=assets/ca-key.pem -config=ca-config.json -profile=client kube-admin.json | cfssljson -bare assets/admin
