# make

Transform GNU make into a simple task runner.

* [Motivation](#motivation)
  * [Portability](#portability)
* [Installation](#installation)
* [Usage](#usage)
  * [Configuration](#configuration)
* [License](#license)

## Motivation

[GNU’s make](https://www.gnu.org/software/make/) is a universal tool that is
available virtually anywhere. It, however, also has a lot of peculiarities and
its default configuration is targeted towards building C projects. This makes
perfect sense, since it was meant for this. By adjusting a few knobs it can be
transformed to a general purpose task runner that is useful in conjunction with
almost any kind of project.

> At this point I would like to point out another great project:
> [🤖 Just](https://github.com/casey/just)
>
> Just is written in Rust and comes along without the GNU make peculiarities.
> It was specifically developed as _just_ a task runner. The project is still
> young and not available everywhere but you might be starting a new project in
> environments you control. Check it out!

GNU make is particularly great for running interactive commands. Something
where even really great build tools like [Gradle](https://gradle.org/) and
[Composer](https://getcomposer.org/) fail to deliver. Its perfect
interoperability with shell scripting is also something that simplifies fast
automation of simple tasks, and all that without a lot of overhead.

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

<!-- TODO installation customization -->

## Usage

<!-- TODO explain how to use it -->

### Configuration

The configuration is stored at `resources/make/config.mk` and stays untouched
when you update your installation. Please refer to the
[default config file](resources/make/config.mk) for an explanation of the most
commonly used options and the defaults.

## License

This is free and unencumbered software released into the public domain.

For more information, please refer to [UNLICENSE](unlicense.md).
