.PHONY: install, remove_with_backups

install:
	/bin/bash scripts/install.sh

remove_with_backups:
	/bin/bash scripts/remove_with_backups.sh

.PHONY: default
default: install
