PREFIX?=/usr/local
INSTALL_NAME = check-permissions

build:
	swift package update
	swift build -c release

install: build
	mkdir -p $(PREFIX)/bin
	mv .build/release/check-permissions-cli .build/release/$(INSTALL_NAME)
	install .build/release/$(INSTALL_NAME) $(PREFIX)/bin

uninstall:
	rm -f $(PREFIX)/bin/$(INSTALL_NAME)