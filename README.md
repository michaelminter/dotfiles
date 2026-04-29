__Rucksack__, everything you need to get started on your journey.

## Dependencies

* Mac 10+

## Installation

Clone the repo:

```
$ cd ~/Projects
$ git clone https://github.com/michaelminter/dotfiles.git
$ cd dotfiles/
```

## Environment variables

This repo uses [`direnv`](https://direnv.net/) to load shell environment
variables (git identity, language versions) from a `.envrc` at the repo root.
`.envrc` is gitignored — copy the example and fill in your own values:

```
$ cp .envrc.example .envrc
$ $EDITOR .envrc
$ direnv allow
```

Once allowed, `direnv` exports the vars automatically whenever you `cd` into
the repo. `install.sh` also sources `.envrc` directly, so it works on a fresh
machine before `direnv` is installed.

`direnv` itself is installed by `brew bundle` (see `mac/Brewfile`). Hook it
into your shell by adding `eval "$(direnv hook bash)"` (or `zsh`) to your
shell rc file.

Open `mac/Brewfile` and comment/uncomment applications you'll be working with.

Run the script and follow the prompts:

```
$ bash install.sh
```
