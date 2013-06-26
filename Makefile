build:
	./build.sh

test: build
	test/run.sh

.SILENT:
.PHONY: build test
