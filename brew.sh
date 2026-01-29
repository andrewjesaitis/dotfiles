#!/bin/bash

set -e

# Check for mutually exclusive flags: --home OR --work
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 [--home | --work]"
    exit 1
fi

if [ "$1" != "--home" ] && [ "$1" != "--work" ]; then
    echo "Invalid option: $1"
    echo "Usage: $0 [--home | --work]"
    exit 1
fi

INSTALL_MODE="$1"
DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Installing packages for environment: $INSTALL_MODE"

# Install Homebrew if not present
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

echo "Updating Homebrew..."
brew update
brew upgrade

# Install common packages from Brewfile
echo "Installing common packages..."
brew bundle --file="$DOTFILES_DIR/Brewfile"

# Install environment-specific packages
if [ "$INSTALL_MODE" = "--work" ]; then
    echo "Installing work-specific packages..."
    brew bundle --file="$DOTFILES_DIR/Brewfile.work"
elif [ "$INSTALL_MODE" = "--home" ]; then
    echo "Installing home-specific packages..."
    brew bundle --file="$DOTFILES_DIR/Brewfile.home"
fi

echo "Success! Brew packages are installed for $INSTALL_MODE environment."
