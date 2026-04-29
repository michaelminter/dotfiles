# mac

macOS bootstrap for a fresh machine. Sets the default shell, drops in dotfiles
(`.bash_profile`, `.gitconfig`, `.gitignore`, `.vimrc`), generates an SSH key,
installs Homebrew, and installs the apps and CLI tools listed in `Brewfile`.

## Layout

| File | Purpose |
| --- | --- |
| `install.sh` | Entry point — prompts for git identity, then runs `main.sh` |
| `main.sh` | Orchestrates each install step (shell, dotfiles, SSH, Homebrew, language managers) |
| `Brewfile` | Declarative list of formulae and casks to install via `brew bundle` |

## Usage

From a clean macOS install:

```
cd ~/Projects/dotfiles/mac
bash install.sh
```

To install or update just the apps and CLI tools:

```
brew bundle
```

Edit `Brewfile` first to comment or uncomment what you want on this machine —
the file ships with a curated set enabled and a larger set commented out.
