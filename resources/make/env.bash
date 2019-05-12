#!/usr/bin/env bash

#!
#! This file is automatically loaded by all Bash scripts that are invoked
#! through make, hence, the instructions in here are global. This avoids that
#! you have to repeat the same preamble in every script you write. The automatic
#! loading is achieved by setting the `BASH_ENV` environment variable in the
#! `bootstrap.mk` file.
#!
#! Note that this also ensures that any `BASH_ENV` that was set in the system is
#! ignored.
#!
#! WARNING! This script must be POSIX compliant because it might be picked up
#! by other Bash invocations that are not using the first Bash in the PATH but
#! rather the system Bash, or even execute Bash in POSIX mode.
#!

[ -n "${DEBUG:-}" ] && set -x
set -Eeuo pipefail
