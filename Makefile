include resources/make/bootstrap.mk

EXECUTABLE_GLOB := bin/* resources/make/utils/* resources/make/env.bash

lint-shell: ## lint all shell scripts
	shopt -s globstar
	exec docker-run-secure koalaman/shellcheck:v0.6.0 \
	    --check-sourced \
	    --color=always \
	    --external-sources \
	    $(EXECUTABLE_GLOB)

lint: lint-shell ## lint everything

permissions: ## add executable bit to all scripts
	chmod +x $(EXECUTABLE_GLOB)

release-%: ## create new GitHub release
	hub release create --edit v$*

run-%: ## run docker container with this project mounted
	exec docker run \
	    --interactive \
	    --rm \
	    --tty \
	    --volume '$(ROOT):/usr/local/src' \
	    --workdir /usr/local/src \
	    $*
