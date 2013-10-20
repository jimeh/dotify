build:
	./build.sh

test: build
	./test.sh

.SILENT:
.PHONY: build test
