# dotfiles

My macOS development environment configuration.

## Installation

```bash
# 1. Clone the repository
git clone https://github.com/andrewjesaitis/dotfiles.git ~/dotfiles

# 2. Install Homebrew packages (choose one)
cd ~/dotfiles
./brew.sh --work   # For work machine
./brew.sh --home   # For personal machine

# 3. Create symlinks
./dotinstall.sh
```

## What's Included

### Shell (Zsh + Oh My Zsh)

- **zprofile** - Environment variables, PATH configuration (Homebrew > User > System)
- **zshrc** - Shell options, aliases, functions, and oh-my-zsh plugins
- **andrewjesaitis.zsh-theme** - Custom prompt theme with git status

**Key aliases:**

- `mkvenv` / `svenv` / `rmvenv` - Python virtual environment management
- `gcp-*` - Google Cloud Platform shortcuts
- `docker-cleanup` - Prune all unused Docker resources

### Git

- **gitconfig** - Aliases, SSH signing via 1Password, auto-setup remote, VS Code as diff/merge tool
- **gitignore_global** - Common files to ignore (`.DS_Store`, compiled files, logs)

**Key aliases:**

- `git st` - status
- `git hist` - pretty log graph
- `git up` - pull with rebase + submodule update
- `git undo` - reset last commit (keep changes)
- `git bclean` - delete merged branches

### Homebrew (Brewfiles)

Uses `brew bundle` for idempotent package management:

- **Brewfile** - Common packages for all machines
- **Brewfile.work** - Work-specific apps (Cursor, Notion)
- **Brewfile.home** - Home-specific apps (Zoom, NordVPN)

**CLI:** `bat`, `fzf`, `git`, `htop`, `jq`, `micro`, `yazi`, `uv`, etc.

**Apps:** 1Password, Docker, VS Code, Ghostty, Google Chrome, and more.

### Tmux

- **tmux.conf** - Prefix key is backtick (\`), mouse support, intuitive pane splitting (`|` and `-`)

## Directory Structure

```
~/dotfiles/
├── andrewjesaitis.zsh-theme  # Custom zsh theme
├── brew.sh                   # Homebrew installer script
├── Brewfile                  # Common Homebrew packages
├── Brewfile.home             # Home-specific packages
├── Brewfile.work             # Work-specific packages
├── dotinstall.sh             # Symlink installer script
├── gitconfig                 # Git configuration
├── gitignore_global          # Global gitignore
├── tmux.conf                 # Tmux configuration
├── zprofile                  # Environment variables
└── zshrc                     # Shell configuration
```

## Post-Install

1. Install Oh My Zsh:
   ```bash
   sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
   ```

2. Copy the custom theme:
   ```bash
   cp ~/dotfiles/andrewjesaitis.zsh-theme ~/.oh-my-zsh/themes/
   ```

3. Install Tmux Plugin Manager:
   ```bash
   git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
   ```
   Then press `prefix + I` inside tmux to install plugins.
