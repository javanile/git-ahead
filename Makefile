
build:
	@mush build --release

install: build
	@chmod +x bin/git-ahead
	@if command -v mush > /dev/null; then mush install --path .; install bin/git-ahead ~/.local/bin/git-ahead; fi
	@echo "git-ahead was installed into ~/.local/bin, please make sure it's in your PATH."

release: build
	@git add .
	@git commit -m "Release" || true
	@git push

test-sort:
	@bash tests/sort-test.sh

test-format:
	@bash tests/format-test.sh

test-list:
	@bash tests/list-test.sh
