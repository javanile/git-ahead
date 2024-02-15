
build:
	@mush build --release

install:
	@chmod +x bin/git-ahead
	@if command -v mush > /dev/null; then mush install --path .; install bin/git-ahead ~/.local/bin/your_file; fi
	@echo "git-ahead was installed into ~/.local/bin, please make sure it's in your PATH."

release: build
	@git add .
	@git commit -m "Release"
	@git push

test-sort:
	@bash tests/sort-test.sh

test-format:
	@bash tests/format-test.sh
