# AGENTS.md

A legend for this dotfiles repo, so an agent (or a human) can orient quickly.

## Root files

| File | Purpose |
| --- | --- |
| `README.md` | Top-level overview: what this repo is, dependencies, and setup instructions |
| `.envrc.example` | Template for `direnv`-loaded environment variables (git identity, language versions) — copy to `.envrc` and fill in real values |
| `.gitignore` | Repo-wide ignore rules (build artifacts, OS cruft, local `.env`/`.envrc`, etc.) |
| `.gitconfig` | Shared git config (aliases, defaults) installed onto a fresh machine |
| `gitconfig` | Same content as `.gitconfig` — source copy referenced by the install scripts |
| `.bash_powerline.sh` | Bash prompt (powerline-style) sourced from shell profiles |
| `.tmux.conf` | tmux configuration |
| `.vimrc` | Vim configuration |
| `utils.sh` | Shared bash helper functions (colored logging, confirmation prompts, OS/command detection, etc.) used by the install scripts |
| `dev-tmux` | Starts a local tmux dev session with panes for common project directories |

## `bin/`

Standalone utility scripts, meant to be run directly or symlinked onto `$PATH`.

| File | Purpose |
| --- | --- |
| `copy-dynamic-email.sh` | Generates a unique `+uuid` Gmail alias and copies it to the clipboard |
| `output_dynamic_email.sh` | Same alias generation, but types it out via `osascript` instead of copying |
| `tmux-frontend` | Kills existing tmux sessions and opens a fresh frontend-focused session |

## `claude/`

| File | Purpose |
| --- | --- |
| `settings.json` | Claude Code settings — permission allowlist, enabled plugins, and MCP server config |

## `debian/`

Bootstrap files for Debian/Linux machines.

| File | Purpose |
| --- | --- |
| `.bash_profile` | Shell profile for Debian machines (aliases, `ls` colors, sources `utils.sh`-style powerline) |

## `mac/`

macOS bootstrap for a fresh machine — see `mac/README.md` for full usage.

| File | Purpose |
| --- | --- |
| `README.md` | Detailed layout and usage for the mac bootstrap scripts |
| `install.sh` | Entry point — prompts for git identity, then runs `main.sh` |
| `main.sh` | Orchestrates each install step (shell, dotfiles, SSH, Homebrew, language managers) |
| `Brewfile` | Declarative list of formulae and casks installed via `brew bundle` |
| `.bash_profile` | Shell profile installed on macOS machines |

## `rails/`

| File | Purpose |
| --- | --- |
| `.ahoy.yml` | `ahoy` command shortcuts for a dockerized Rails/Elixir-style project (up/down/test/migrate/etc.) |

## `vscode/`

| File | Purpose |
| --- | --- |
| `README.md` | Explains the recommended extensions and how `.extensions.json` doubles as a backup/restore list |
| `.extensions.json` | List of recommended/installed VS Code extensions, used both for new-project recommendations and machine backup-restore |
