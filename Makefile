SHELL := /usr/bin/env bash

.PHONY: bootstrap lint format test

bootstrap:
	./bootstrap.sh

lint:
	find . -type f -name "*.sh" -print0 | xargs -0 shellcheck

format:
	find . -type f -name "*.sh" -print0 | xargs -0 shfmt -w

test:
	@echo "No tests yet."