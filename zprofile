# Path settings
# Order: Homebrew > User > System
typeset -U path PATH
path=(
    # Homebrew
    /opt/homebrew/bin
    /opt/homebrew/sbin

    # User
    $HOME/.local/bin
    $HOME/projects/go/bin

    # System
    /usr/local/bin
    /usr/local/sbin
    /usr/bin
    /bin
    /usr/sbin
    /sbin
    /opt/X11/bin
)
export PATH="${(j/:/)path}"

# Editor settings
export ALTERNATE_EDITOR="nano"
export EDITOR="micro"
export VISUAL="micro"

# Golang settings
export GOPATH=$HOME/projects/go

# Python settings
export PYTHONDONTWRITEBYTECODE=1

# History settings
export HISTFILESIZE=10000
export HISTSIZE=500
