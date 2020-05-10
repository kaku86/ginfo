NAME := ginfo

.PHONY: gofmt
gofmt:
	goimports -w ./

.PHONY: golint
golint:
	golint ./...

.PHONY: govet
govet:
	go vet ./...

.PHONY: gobuild
gobuild:
	go build -o ./dists/$(NAME).exe ./cmd/$(NAME)/main.go
	cp -p ./configs/labels.yaml ./dists

.PHONY: fmt
fmt: gofmt

.PHONY: lint
lint: golint govet

.PHONY: build
build: fmt lint gobuild tags

.PHONY: tags
tags:
	ctags --options=NONE --options=.ctags -R -f .tags

.PHONY: clean
clean:
	rm -r ./dists
