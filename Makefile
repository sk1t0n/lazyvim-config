.PHONY: install, delete, generate

install:
	/bin/bash scripts/install.sh
	/bin/bash scripts/generate_lua_files.sh

DELETE_WITH_BACKUPS ?=
delete:
	/bin/bash scripts/delete.sh $(DELETE_WITH_BACKUPS)

generate:
	/bin/bash scripts/generate_lua_files.sh

.PHONY: default
default: install
