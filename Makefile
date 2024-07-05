PREFIX?=/usr/local
INSTALL_NAME = check-permissions-cli

build:
	swift package update
	swift build -c release

install_bin:
	mkdir -p $(PREFIX)/bin
	mv .build/release/check-permissions-cli .build/release/$(INSTALL_NAME)
	install .build/release/$(INSTALL_NAME) $(PREFIX)/bin

uninstall:
	rm -f $(PREFIX)/bin/$(INSTALL_NAME)