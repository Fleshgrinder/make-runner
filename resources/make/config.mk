#!
#! User specific configuration file. This file stayes untouched during updates
#! of your make framework and allows you to customize apsects of your
#! installation.
#!

# A task runner should not conditionally execute goals but rather always execute
# them and this is exactly what this option does. The default user configuration
# enables this mode because this is the most convenient mode to work with make
# if you want to use it as a task runner. However, you can also drop this option
# and use make's default mode of operation, which can be useful in various
# situations.
#
# Note that the most efficient but also most anyoing way of making goals
# unconditional is to use `.PHONY := goal` directly before you define your goal.
#
# A less known feature of make are double-colon rules, see:
# https://www.gnu.org/software/make/manual/html_node/Double_002dColon.html
# Goals defined with a double-colon rule are unconditional as long as they have
# no prerequisites (which can be unconditional on their own). This might be a
# feasable alternative to writing `.PHONY` everywhere.
MAKEFLAGS += --always-make

# Uncomment the following line to enable the export-all mode of GNU make. All
# variables are exported by default in this mode and no explicit `export` is
# required. This can be very handy if you work with `.env` files but it might
# also be undesired in other situations, default is to export everything
# explicitly.
#
# https://www.gnu.org/software/make/manual/html_node/Special-Targets.html
#.EXPORT_ALL_VARIABLES:
