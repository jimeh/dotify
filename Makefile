test: build prepare
	./test.sh

build:
	./build.sh

prepare: prepare-assert.sh prepare-stub.sh

prepare-assert.sh:
	test -f "test/assert.sh" || ( \
		echo "fetching assert.sh..." && \
		curl -s -L -o test/assert.sh \
			https://raw.github.com/lehmannro/assert.sh/v1.0.2/assert.sh \
	)

prepare-stub.sh:
	test -f "test/stub.sh" || ( \
		echo "fetching stub.sh..." && \
		curl -s -L -o test/stub.sh \
			https://raw.github.com/jimeh/stub.sh/v0.2.0/stub.sh \
	)

.SILENT:
.PHONY: build test prepare preare-assert.sh prepare-stub.sh
