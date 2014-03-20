test: build prepare
	./test.sh

build:
	./build.sh

prepare: prepare-assert.sh prepare-stub.sh

prepare-assert.sh:
	test -f "test/assert.sh" || ( \
		echo "fetching test/assert.sh..." && \
		curl -s -L -o test/assert.sh \
			https://raw.github.com/lehmannro/assert.sh/v1.0.2/assert.sh \
	)

update-assert.sh: remove-assert.sh prepare-assert.sh

remove-assert.sh:
	test -f "test/assert.sh" && \
		rm "test/assert.sh" && \
		echo "removed test/assert.sh"

prepare-stub.sh:
	test -f "test/stub.sh" || ( \
		echo "fetching test/stub.sh..." && \
		curl -s -L -o test/stub.sh \
			https://raw.github.com/jimeh/stub.sh/v0.3.0/stub.sh \
	)

update-stub.sh: remove-stub.sh prepare-stub.sh

remove-stub.sh:
	test -f "test/stub.sh" && \
		rm "test/stub.sh" && \
		echo "removed test/stub.sh"

.SILENT:
.PHONY: build test prepare preare-assert.sh prepare-stub.sh
