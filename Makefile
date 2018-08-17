# This Makefile is meant to be used by people that do not usually work
# with Go source code. If you know what GOPATH is then you probably
# don't need to bother with make.

.PHONY: proton android ios proton-cross swarm evm all test clean
.PHONY: proton-linux proton-linux-386 proton-linux-amd64 proton-linux-mips64 proton-linux-mips64le
.PHONY: proton-linux-arm proton-linux-arm-5 proton-linux-arm-6 proton-linux-arm-7 proton-linux-arm64
.PHONY: proton-darwin proton-darwin-386 proton-darwin-amd64
.PHONY: proton-windows proton-windows-386 proton-windows-amd64

GOBIN = $(shell pwd)/build/bin
GO ?= latest

proton:
	build/env.sh go run build/ci.go install ./cmd/proton
	@echo "Done building."
	@echo "Run \"$(GOBIN)/proton\" to launch proton."

swarm:
	build/env.sh go run build/ci.go install ./cmd/swarm
	@echo "Done building."
	@echo "Run \"$(GOBIN)/swarm\" to launch swarm."

all:
	build/env.sh go run build/ci.go install

android:
	build/env.sh go run build/ci.go aar --local
	@echo "Done building."
	@echo "Import \"$(GOBIN)/proton.aar\" to use the library."

ios:
	build/env.sh go run build/ci.go xcode --local
	@echo "Done building."
	@echo "Import \"$(GOBIN)/Smc.framework\" to use the library."

test: all
	build/env.sh go run build/ci.go test

clean:
	rm -fr build/_workspace/pkg/ $(GOBIN)/*

# The devtools target installs tools required for 'go generate'.
# You need to put $GOBIN (or $GOPATH/bin) in your PATH to use 'go generate'.

devtools:
	env GOBIN= go get -u golang.org/x/tools/cmd/stringer
	env GOBIN= go get -u github.com/jteeuwen/go-bindata/go-bindata
	env GOBIN= go get -u github.com/fjl/gencodec
	env GOBIN= go install ./cmd/abigen

# Cross Compilation Targets (xgo)

proton-cross: proton-linux proton-darwin proton-windows proton-android proton-ios
	@echo "Full cross compilation done:"
	@ls -ld $(GOBIN)/proton-*

proton-linux: proton-linux-386 proton-linux-amd64 proton-linux-arm proton-linux-mips64 proton-linux-mips64le
	@echo "Linux cross compilation done:"
	@ls -ld $(GOBIN)/proton-linux-*

proton-linux-386:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/386 -v ./cmd/proton
	@echo "Linux 386 cross compilation done:"
	@ls -ld $(GOBIN)/proton-linux-* | grep 386

proton-linux-amd64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/amd64 -v ./cmd/proton
	@echo "Linux amd64 cross compilation done:"
	@ls -ld $(GOBIN)/proton-linux-* | grep amd64

proton-linux-arm: proton-linux-arm-5 proton-linux-arm-6 proton-linux-arm-7 proton-linux-arm64
	@echo "Linux ARM cross compilation done:"
	@ls -ld $(GOBIN)/proton-linux-* | grep arm

proton-linux-arm-5:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm-5 -v ./cmd/proton
	@echo "Linux ARMv5 cross compilation done:"
	@ls -ld $(GOBIN)/proton-linux-* | grep arm-5

proton-linux-arm-6:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm-6 -v ./cmd/proton
	@echo "Linux ARMv6 cross compilation done:"
	@ls -ld $(GOBIN)/proton-linux-* | grep arm-6

proton-linux-arm-7:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm-7 -v ./cmd/proton
	@echo "Linux ARMv7 cross compilation done:"
	@ls -ld $(GOBIN)/proton-linux-* | grep arm-7

proton-linux-arm64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm64 -v ./cmd/proton
	@echo "Linux ARM64 cross compilation done:"
	@ls -ld $(GOBIN)/proton-linux-* | grep arm64

proton-linux-mips:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mips --ldflags '-extldflags "-static"' -v ./cmd/proton
	@echo "Linux MIPS cross compilation done:"
	@ls -ld $(GOBIN)/proton-linux-* | grep mips

proton-linux-mipsle:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mipsle --ldflags '-extldflags "-static"' -v ./cmd/proton
	@echo "Linux MIPSle cross compilation done:"
	@ls -ld $(GOBIN)/proton-linux-* | grep mipsle

proton-linux-mips64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mips64 --ldflags '-extldflags "-static"' -v ./cmd/proton
	@echo "Linux MIPS64 cross compilation done:"
	@ls -ld $(GOBIN)/proton-linux-* | grep mips64

proton-linux-mips64le:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mips64le --ldflags '-extldflags "-static"' -v ./cmd/proton
	@echo "Linux MIPS64le cross compilation done:"
	@ls -ld $(GOBIN)/proton-linux-* | grep mips64le

proton-darwin: proton-darwin-386 proton-darwin-amd64
	@echo "Darwin cross compilation done:"
	@ls -ld $(GOBIN)/proton-darwin-*

proton-darwin-386:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=darwin/386 -v ./cmd/proton
	@echo "Darwin 386 cross compilation done:"
	@ls -ld $(GOBIN)/proton-darwin-* | grep 386

proton-darwin-amd64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=darwin/amd64 -v ./cmd/proton
	@echo "Darwin amd64 cross compilation done:"
	@ls -ld $(GOBIN)/proton-darwin-* | grep amd64

proton-windows: proton-windows-386 proton-windows-amd64
	@echo "Windows cross compilation done:"
	@ls -ld $(GOBIN)/proton-windows-*

proton-windows-386:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=windows/386 -v ./cmd/proton
	@echo "Windows 386 cross compilation done:"
	@ls -ld $(GOBIN)/proton-windows-* | grep 386

proton-windows-amd64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=windows/amd64 -v ./cmd/proton
	@echo "Windows amd64 cross compilation done:"
	@ls -ld $(GOBIN)/proton-windows-* | grep amd64
