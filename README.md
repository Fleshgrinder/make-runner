# make-runner

Transform [GNU Make] into a simple task runner.

* [Motivation](#motivation)
  * [Portability](#portability)
* [Installation](#installation)
  * [Recommended Software](#recommended-software)
* [Usage](#usage)
  * [Writing Makefils](#writing-makefiles)
* [License](#license)

## Motivation

[GNU Make] is a universal tool that is available virtually anywhere. It, 
however, also has a lot of peculiarities and its default configuration is 
targeted towards building C projects. This makes perfect sense since it was 
meant for this. By adjusting a few knobs it can be transformed into a general 
purpose task runner that is useful in conjunction with almost any kind of 
project.

> At this point, I would like to point out another great project:
> [🤖 Just](https://github.com/casey/just)
>
> Just is written in Rust and comes along without the GNU make peculiarities.
> It was specifically developed as _just_ a task runner. The project is still
> young and not available everywhere but you might be starting a new project in
> environments you control. Check it out!

GNU make is particularly great for running interactive commands. Something
where even really great build tools like [Gradle](https://gradle.org/) fail to 
deliver. Its perfect interoperability with shell scripting is also something 
that simplifies fast automation of simple tasks, and all that without a lot of 
overhead.

### Portability

Writing scripts to automate common tasks is simple and fast, however, sharing
them between different users with different operating systems is not. We
usually can ignore Windows because there are enough projects out there that
offer them access to the GNU world, even provided by Microsoft itself. However,
portability between Linux and Mac (or BSD in general) is a different story.

A clear goal of this project is to provide abstractions that ensure portability
between Linux and Mac.

## Installation

This framework is meant to be installed inside your git repository and that you
commit its files to your repository. Execute the following command inside the
root of your project’s git repository:

```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Fleshgrinder/make-runner/v0.1.0/bin/installer)"
```

You will find a `Makefile` in the root of your repository after the installer
finished and you are ready to go.

### Recommended Software

You should install some programs in order to get the most out of your 
`make-runner` installation. In fact, every user of your repositories should 
install those programs because otherwise, it will be hard for you to write 
scripts, well, unless you run absolutely everything through Docker. While in 
general, it’s recommendable to run as much as possible through Docker, not 
everything makes sense.

Scripts are included to simplify the bootstrapping of a new system. They are 
available via the command `make bootstrap-system` which tries to detect the 
operating system and install the right software. Note that this command requires 
you to use `sudo` on a Linux system.

You can also install everything manually or even before you run the installer by 
executing the bootstrap script that matches your system. Have a look at the 
`bin` directory and the `bootstrap-` scripts. You can execute any of them like 
the installer. On a Mac you would execute the following command:

```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Fleshgrinder/make-runner/v0.1.0/bin/bootstrap-mac)"
```

What exactly is being installed depends on the system, but in general the
following software is recommended:

* [curl](https://curl.haxx.se/)
* [dos2unix](http://dos2unix.sourceforge.net/)
* [git](https://git-scm.com/)
* [GNU Awk](https://www.gnu.org/software/gawk/)
* [GNU Bash](https://www.gnu.org/software/bash/)
* [GNU Coreutils](https://www.gnu.org/software/coreutils/)
* [GNU Findutils](https://www.gnu.org/software/findutils/)
* [GNU Grep](https://www.gnu.org/software/grep/)
* [GNU Make]
* [GNU PG](https://www.gnupg.org/)
* [GNU Readline](https://www.gnu.org/software/readline/)
* [GNU Sed](https://www.gnu.org/software/sed/)
* [GNU Tar](https://www.gnu.org/software/tar/)
* [hub](https://hub.github.com/)
* [jq](https://stedolan.github.io/jq/)

You undoubtedly noticed that most of the things from this list are GNU projects. 
The idea is to ensure portability by standardizing on the default tools that 
come along with most Linux distros and free software. Also, most of the help you 
will find online is targeting GNU tools. Standardizing on them means that you 
can reuse that information for your scripts.

## Usage

Be sure to read about the [recommended software](#recommended-software) before
you continue. Also make sure to install the recommended software on all systems
you target, otherwise you might run into compatibility and portability issues.

> A typical problem is Bash on Mac. Apple ships a very old version and users are
> not aware of that. Many Bash features will not be available with this ancient
> Bash version and fail with weird error messages.

You will find a few new files in your repository after the 
[installation](#installation), let’s go through them. 
[`resources/make`](resources/make) contains all files that make up the 
`make-runner` project and the most important file in there is 
[`bootstrap.mk`](resources/make/bootstrap.mk). It contains the logic that turns
[GNU Make] into a simple task runner by applying various defaults. Take your
time and go through it. Everything inside it is properly documented and should
not leave any questions unanswered (open an issue if you think that anything is
not clear and requires a better explanation).

There is also the [`config.mk`](resources/make/config.mk) with a few defaults.
This file can be customized by you and is always loaded in the bootstrap 
process. It is the perfect place to collect global settings of your own project.

Next up are the utilities that you find the [`utils`](resources/make/utils)
directory. All scripts in that directory are available to you globally, meaning,
you can call them from your own Bash scripts without any special setup as long
as you go through `make-runner`. Go through the various scripts and read their
documentation.

### Writing Makefiles

Write your Makefiles like you always do and simply include
[`resources/make/bootstrap.mk`](resources/make/bootstrap.mk), however, always
include it after all other includes. This ensures that the special `make help`
(aka. `make goals`, `make targets`) goal can pick up all goals in its output.

Speaking of which, you can control which goals show up in `make help` by 
including a comment after the goal signature that starts with two hash signs,
e.g.:

```makefile
include resources/make/bootstrap.mk

goal-that-shows-up-in-make-help: ## this text will be displayed next to it
	:

this-will-not-show-up: # :)
	:

```

## License

This is free and unencumbered software released into the public domain.

For more information, please refer to [UNLICENSE](./UNLICENSE.md).

[GNU Make]: https://www.gnu.org/software/make/
