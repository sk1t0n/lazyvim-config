.PHONY: install, delete

install:
	/bin/bash scripts/install.sh
	/bin/bash scripts/generate_lua_files.sh

DELETE_WITH_BACKUPS ?=
delete:
	/bin/bash scripts/delete.sh $(DELETE_WITH_BACKUPS)

.PHONY: default
default: install
