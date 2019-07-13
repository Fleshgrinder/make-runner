#!
#! This file bootstraps our Makefiles and turns make into a simple task runner
#! by disabling all peculiarities of make that often get in our way if we just
#! want to run some simple commands.
#!

# ----------------------------------------------------------------------- config

# Determine the root directory of this repository which allows us to include
# files, no matter from where we were invoked.
override ROOT := $(shell p="$(CURDIR)"; while [ "$$p" != / ] && [ ! -d "$$p/.git" ]; do p="$${p%/*}"; done; echo "$$p")
export ROOT

# Nobody should ever install this in the root.
ifeq ($(ROOT),/)
$(error Could not find root of repository, are you inside a make enabled repository? Ensure that `.makeroot` exists in the root of your repository.)
endif

# Loads the user specific configuration.
include $(ROOT)/resources/make/config.mk

# --------------------------------------------------------------------- features

# Disable/enable various make features.
#
# https://www.gnu.org/software/make/manual/html_node/Options-Summary.html
MAKEFLAGS += --no-builtin-rules
MAKEFLAGS += --no-builtin-variables
MAKEFLAGS += --no-print-directory
MAKEFLAGS += --warn-undefined-variables

# Never delete a target if it exits with an error.
#
# https://www.gnu.org/software/make/manual/html_node/Special-Targets.html
.DELETE_ON_ERROR :=

# The shell that should be used to execute the recipes as well as the default
# settings that should be used by every script we invoke.
SHELL           := bash
.SHELLFLAGS     := -euo pipefail -c
export BASH_ENV := $(ROOT)/resources/make/env.bash

# This makes all goals silent by default, unless DEBUG is set. We want to follow
# the UNIX rule of silence and not overwhelm users with tons of output that
# hides failures.
#
# http://www.linfo.org/rule_of_silence.html
ifndef DEBUG
.SILENT:
endif

# We are using GNU make and thus can use .PHONY or even --always-build (as is
# the default in our config.mk). However, there are situations in which you
# might require the emtpy FORCE goal despite all these options and they usually
# revolve around pattern rule goals that cannot be made unconditional in any
# other way than using --always-build (which might not be what you want) and in
# those cases FORCE is your best friend:
#
# https://www.gnu.org/software/make/manual/html_node/Force-Targets.html
FORCE:

# Execute the body of goals in a single shell. This improves performance, by not
# spawning a new shell for each line, and also allows us to write multiline
# commands like conditions and loops without escaping.
#
# https://www.gnu.org/software/make/manual/html_node/One-Shell.html
.ONESHELL:

# Disables the suffix functionality of make.
#
# https://www.gnu.org/software/make/manual/html_node/Suffix-Rules.html
.SUFFIXES:

# Ensures that we are using the GNU executables on a Mac instead of BSD stuff.
# This greatly increases portability of the scripts we write. We expect Mac
# users to install these things via brew which is the de facto standard on Mac
# for installing such things.
ifeq ($(shell uname),Darwin)
BREW_PREFIX ?= /usr/local
PATH := $(BREW_PREFIX)/opt/coreutils/libexec/gnubin:$(PATH)
PATH := $(BREW_PREFIX)/opt/curl-openssl/bin:$(PATH)
PATH := $(BREW_PREFIX)/opt/findutils/libexec/gnubin:$(PATH)
PATH := $(BREW_PREFIX)/opt/gnu-getopt/bin:$(PATH)
PATH := $(BREW_PREFIX)/opt/gnu-indent/libexec/gnubin:$(PATH)
PATH := $(BREW_PREFIX)/opt/gnu-sed/libexec/gnubin:$(PATH)
PATH := $(BREW_PREFIX)/opt/gnu-tar/libexec/gnubin:$(PATH)
PATH := $(BREW_PREFIX)/opt/grep/libexec/gnubin:$(PATH)
PATH := $(BREW_PREFIX)/opt/make/libexec/gnubin:$(PATH)
endif

# We extend the PATH with some repository specific directories. This allows us
# to write dedicated scripts instead of inlining everything within our
# Makefiles. This also means that we can lint the scripts easily, which would
# not be possible if we would have them inline.
#
# * `resources/make/utils` contains make runner specific scripts that are
#   distributed along with it. Nobody should place anything in there.
# * `resources/make/bin` contains make runner specific user scripts. This is
#   where we place the scripts for our own custom goals.
# * `bin` contains global user scripts that can be invoked directly or via the
#   make runner.
export PATH := $(ROOT)/resources/make/utils:$(ROOT)/resources/make/bin:$(ROOT)/bin:$(PATH)

# ------------------------------------------------------------------- exit codes
# We use these constants in our scripts to create more meaningful exit codes.
# This helps us while writing scripts to know exactly what went wrong and react
# to it accordingly.
#
# * https://gist.github.com/bojanrajkovic/831993
# * https://www.tldp.org/LDP/abs/html/exitcodes.html

export EX_OK          := 0
export EX_UNKNOWNERR  := 1
export EX_USAGE       := 64
export EX_DATAERR     := 65
export EX_NOINPUT     := 66
export EX_NOUSER      := 67
export EX_NOHOST      := 68
export EX_UNAVAILABLE := 69
export EX_SOFTWARE    := 70
export EX_OSERR       := 71
export EX_OSFILE      := 72
export EX_CANTCREAT   := 73
export EX_IOERR       := 74
export EX_TEMPFAIL    := 75
export EX_PROTOCOL    := 76
export EX_NOPERM      := 77
export EX_CONFIG      := 78

# ----------------------------------------------------------------------- colors
# ANSI escape sequences for coloring of output.
#
# ## Example
#
# * Makefile: `echo -e '$(FG_GREEN)Success$(RESET_COLORS)'`
# * Script: `echo -e "${FG_GREEN}Success${RESET_COLORS}"`

# https://no-color.org/
ifdef NO_COLOR
export RESET_COLORS    :=

export FG_BLACK        :=
export FG_BLUE         :=
export FG_CYAN         :=
export FG_GRAY         :=
export FG_GREEN        :=
export FG_LIGHT_BLUE   :=
export FG_LIGHT_CYAN   :=
export FG_LIGHT_GRAY   :=
export FG_LIGHT_GREEN  :=
export FG_LIGHT_PURPLE :=
export FG_LIGHT_RED    :=
export FG_MAGENTA      :=
export FG_RED          :=
export FG_WHITE        :=
export FG_YELLOW       :=

export BG_BLACK        :=
export BG_BLUE         :=
export BG_CYAN         :=
export BG_GREEN        :=
export BG_MAGENTA      :=
export BG_RED          :=
export BG_WHITE        :=
export BG_YELLOW       :=

export BOX_BLACK       :=
export BOX_BLUE        :=
export BOX_CYAN        :=
export BOX_GREEN       :=
export BOX_MAGENTA     :=
export BOX_RED         :=
export BOX_WHITE       :=
export BOX_YELLOW      :=
else
export RESET_COLORS    := \033[0m

export FG_BLACK        := \033[0;30m
export FG_BLUE         := \033[0;34m
export FG_CYAN         := \033[0;36m
export FG_GRAY         := \033[1;30m
export FG_GREEN        := \033[0;32m
export FG_LIGHT_BLUE   := \033[1;34m
export FG_LIGHT_CYAN   := \033[1;36m
export FG_LIGHT_GRAY   := \033[0;37m
export FG_LIGHT_GREEN  := \033[1;32m
export FG_LIGHT_PURPLE := \033[1;35m
export FG_LIGHT_RED    := \033[1;31m
export FG_MAGENTA      := \033[0;35m
export FG_RED          := \033[0;31m
export FG_WHITE        := \033[0;37m
export FG_YELLOW       := \033[0;33m

export BG_BLACK        := \033[40m
export BG_BLUE         := \033[44m
export BG_CYAN         := \033[46m
export BG_GREEN        := \033[42m
export BG_MAGENTA      := \033[45m
export BG_RED          := \033[41m
export BG_WHITE        := \033[47m
export BG_YELLOW       := \033[43m

export BOX_BLACK       := \033[37;40m
export BOX_BLUE        := \033[30;44m
export BOX_CYAN        := \033[30;46m
export BOX_GREEN       := \033[30;42m
export BOX_MAGENTA     := \033[30;45m
export BOX_RED         := \033[37;41m
export BOX_WHITE       := \033[30;47m
export BOX_YELLOW      := \033[30;43m
endif

# ---------------------------------------------------------------- default goals

.PHONY: help goals targets
help goals targets: ## display all available make goals and exit
	make-goals $(MAKEFILE_LIST)

.PHONY: env
env: ## display make’s environment and exit
	env

bootstrap-system: ## install recommended software
	exec $@
