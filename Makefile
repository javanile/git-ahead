
build:
	@mush build --release

install:
	@mush install --path .

test-sort:
	@bash tests/sort-test.sh

test-format:
	@bash tests/format-test.sh
