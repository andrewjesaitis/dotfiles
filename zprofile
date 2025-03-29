# Path settings
path=(
    /usr/local/bin
    /usr/bin
    /bin
    /usr/sbin
    /sbin
    /opt/X11/bin
    /usr/local/sbin
    /opt/homebrew/bin
    /opt/homebrew/sbin
    $HOME/.local/bin
    $PATH
)
export PATH="${(j/:/)path}"


# Editor settings
export ALTERNATE_EDITOR="nano"
export EDITOR="nano"
export VISUAL="nano"

# Golang settings
export GOROOT=/usr/local/go
export GOPATH=$HOME/projects/go
export PATH=$GOROOT/bin:$GOPATH/bin/:$PATH

# Python settings
export PYTHONDONTWRITEBYTECODE=1
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"

# History settings
export HISTFILESIZE=10000
export HISTSIZE=500
