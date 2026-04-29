# Recommended VS Code Extensions
This document lists recommended Visual Studio Code extensions for this project, configured in `.vscode/extensions.json`. These extensions enhance development experience, improve code quality, and provide better tooling for specific technologies used in the project.

## Extensions
Below is a list of the recommended extensions and a brief description of what they do:

- esbenp.prettier-vscode
  - Code formatter using Prettier. This extension integrates Prettier into VS Code, automatically formatting your code to ensure consistent styling across the project.

- bradlc.vscode-tailwindcss
  - Intelligent Tailwind CSS tooling for VS Code. Provides advanced features like intelligent autocompletion, linting, and hover information for Tailwind CSS classes.

- heybourn.headwind
  - An opinionated class sorter for Tailwind CSS. Automatically sorts your Tailwind CSS classes in a consistent order, making your HTML cleaner and more readable.

- Shopify.ruby-lsp
  - VS Code plugin for connecting with the Ruby LSP (Language Server Protocol). Offers features like go-to-definition, autocompletion, and diagnostics for Ruby projects.

## Installation
When you open this project in VS Code, you should be prompted to install these recommended extensions. If not, you can manually install them by navigating to the Extensions view (`Ctrl+Shift+X` or `Cmd+Shift+X`) and searching for each extension by its ID (e.g., `esbenp.prettier-vscode`).

## Backup and restore

`.extensions.json` doubles as a backup of every extension currently installed
in VS Code, so a fresh machine can be rehydrated in one shot.

Refresh the backup from the current machine (run after installing or removing
extensions):

```
code --list-extensions | jq -R . | jq -s '{recommendations: .}' > vscode/.extensions.json
```

Restore on a new machine (requires `jq` and the `code` CLI on `$PATH`):

```
jq -r '.recommendations[]' vscode/.extensions.json | xargs -L1 code --install-extension
```