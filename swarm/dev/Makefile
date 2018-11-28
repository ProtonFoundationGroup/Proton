.PHONY: build cluster test

default: build

build:
	go build -o bin/swarm    github.com/ProtonFoundation/Proton/cmd/swarm
	go build -o bin/geth     github.com/ProtonFoundation/Proton/cmd/geth
	go build -o bin/bootnode github.com/ProtonFoundation/Proton/cmd/bootnode

cluster: build
	scripts/boot-cluster.sh

test:
	go test -v github.com/ProtonFoundation/Proton/swarm/...
