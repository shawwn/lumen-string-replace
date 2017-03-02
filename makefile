.PHONY: all clean test

LUMEN_LUA  ?= lua
LUMEN_NODE ?= node
LUMEN_HOST ?= $(LUMEN_LUA)

LUMEN ?= LUMEN_HOST="$(LUMEN_HOST)" lumen

all: index.js init.lua

clean:
	@git checkout *.js *.lua

init.lua: lib.l
	@echo $@
	@$(LUMEN) -c $< -o $@ -t lua

index.js: lib.l
	@echo $@
	@$(LUMEN) -c $< -o $@ -t js

test: all
	@echo js:
	@LUMEN_HOST=$(LUMEN_NODE) ./test.l
	@echo lua:
	@LUMEN_HOST=$(LUMEN_LUA) ./test.l
