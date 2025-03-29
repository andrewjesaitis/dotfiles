#!/bin/bash

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
echo "Installing packages for environment: $INSTALL_MODE"

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"

brew update
brew upgrade

# Common packages for both environments
brew install htop      # Interactive process viewer and system monitor
brew install git       # Distributed version control system
brew install wget      # Tool for retrieving files using HTTP/HTTPS and FTP
brew install git-lfs   # Git extension for versioning large files
brew install nvm       # Node Version Manager for managing multiple Node.js versions
brew install pyenv     # Python Version Manager for managing multiple Python versions
brew install readline  # Library for command-line editing and history
brew install sqlite3   # Command-line interface for SQLite database
brew install zlib      # Data compression library
brew install jq        # Lightweight command-line JSON processor
brew install npm       # Node Package Manager

# Wait a bit before moving on...
sleep 1

# ...and then.
echo "Success! Basic brew packages are installed."

# Common cask packages
brew install --cask arc        # Arc web browser
brew install --cask google-chrome      # Google Chrome web browser
brew install --cask 1password-gui      # 1Password password manager with GUI interface
brew install --cask 1password-cli      # 1Password command line interface
brew install --cask chatgpt            # ChatGPT desktop client
brew install --cask visual-studio-code # Visual Studio Code code editor
brew install --cask postman            # Postman API development and testing tool
brew install --cask docker             # Docker container platform for building and shipping apps
brew install --cask beekeeper-studio   # Beekeeper SQL editor and database manager
brew install --cask superwhisper       # SuperWhisper audio transcription tool using Whisper AI
brew install --cask appcleaner         # AppCleaner app uninstaller
brew install --cask imageoptim         # ImageOptim image optimizer
brew install --cask figma              # Figma collaborative design tool
brew install --cask the-unarchiver     # The Unarchiver archive extraction utility
brew install --cask vlc                # VLC media player
brew install --cask monitorcontrol     # MonitorControl external display brightness control
brew install --cask kap                # Kap screen recorder with GIF support
brew install --cask google-cloud-sdk   # Google Cloud SDK tools

# Fonts
brew install --cask font-fira-code
brew install --cask font-fira-sans
brew install --cask font-fira-mono
brew install --cask font-source-code-pro
brew install --cask font-fantasque-sans-mono
brew install --cask font-inconsolata

# Quick Look Plugins (https://github.com/sindresorhus/quick-look-plugins)
brew install --cask qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql qlimagesize webpquicklook qlvideo

# Install environment-specific packages
if [ "$INSTALL_MODE" = "--work" ]; then
    # Work specific packages
    brew install --cask cursor
    brew install --cask notion
    brew install --cask rippling
elif [ "$INSTALL_MODE" = "--home" ]; then
    # Home specific packages
    brew install --cask zoom
    brew install --cask obsidian
    brew install --cask nordvpn
else
    echo "Warning: Unknown INSTALL_MODE '$INSTALL_MODE', skipping environment-specific packages"
fi

# Wait a bit before moving on...
sleep 1

# ...and then.
echo "Success! Brew packages are installed for $INSTALL_MODE environment."
