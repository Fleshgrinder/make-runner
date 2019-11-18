include resources/make/runner/bootstrap.mk

EXECUTABLE_GLOB := bin/* test/* "$(MAKE_RUNNER_ROOT)"/bin/* "$(MAKE_RUNNER_ROOT)"/env.bash

.PHONY: lint-shell
lint-shell: ## lint all shell scripts
	docker-run-secure koalaman/shellcheck:v0.7.0 --check-sourced --color=always --external-sources $(EXECUTABLE_GLOB)

.PHONY: lint
lint: lint-shell ## lint everything

.PHONY: permissions
permissions: ## add executable bit to all scripts
	chmod +x $(EXECUTABLE_GLOB)

release-%: ## create new GitHub release
	hub release create --edit v$*

run-%: ## run docker container with this project mounted
	docker-run --interactive --tty $*

.PHONY: test
test: ## execute all tests
	run-tests
