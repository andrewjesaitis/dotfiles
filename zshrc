# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Theme
ZSH_THEME="andrewjesaitis"

# Better directory navigation
setopt LIST_AMBIGUOUS       # List ambiguous completions
setopt AUTO_PUSHD          # Push the old directory onto the stack on cd
setopt PUSHD_IGNORE_DUPS   # Don't store duplicates in the stack
setopt PUSHD_SILENT        # Don't print directory stack after pushd/popd

# Better history
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format
setopt SHARE_HISTORY             # Share history between all sessions
setopt HIST_EXPIRE_DUPS_FIRST   # Expire duplicate entries first when trimming history
setopt HIST_IGNORE_DUPS         # Don't record an entry that was just recorded again
setopt HIST_IGNORE_ALL_DUPS     # Delete old recorded entry if new entry is a duplicate
setopt HIST_FIND_NO_DUPS        # Do not display a line previously found
setopt HIST_SAVE_NO_DUPS        # Don't write duplicate entries in the history file

# Better completion
setopt COMPLETE_IN_WORD    # Complete from both ends of a word
setopt ALWAYS_TO_END       # Move cursor to the end of a completed word

# Initialize zsh's advanced completion system
autoload -Uz compinit && compinit -i

# Comment this out to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="false"

# Update Oh my zsh every month
export UPDATE_ZSH_DAYS=30

# Oh my zsh plugins
plugins=(colored-man-pages sudo colorize history python dotenv)

# Oh my zsh setup magic
source "$ZSH/oh-my-zsh.sh"

# Disable the bell
if [[ $iatest -gt 0 ]]; then bind "set bell-style visible"; fi

fpath=(~/.zsh/completion $fpath)

# Lazy load nvm
export NVM_DIR="$HOME/.nvm"
nvm() {
    unset -f nvm
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    nvm "$@"
}

#Git aliases
alias got='git '
alias get='git '

#Docker aliases
alias docker_kill_all='docker kill $(docker ps -q)'
alias docker_rm_all='docker rm $(docker ps -a -q)'
alias docker_rmi_all='docker rmi $(docker images -q)'
alias dcd='docker-compose down'
alias dcu='docker-compose up'
alias dcp='docker-compose pull'
alias dcb='docker-compose build'

# Virtual Env
alias mkvenv='python3 -m venv .venv && source .venv/bin/activate'
alias rmvenv='rm -rf .venv && deactivate'
alias svenv='source .venv/bin/activate'

#Perhaps you should include this apple, hmmmm....
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

# GCP Aliases
alias gcp-login='gcloud auth application-default login'
alias gcp-logout='gcloud auth revoke'
alias gcp-list-projects='gcloud projects list'
alias gcp-current-project='gcloud config list --format="value(core.project)"'

# Show current network connections to the server
alias ipview="netstat -anpl | grep :80 | awk {'print \$5'} | cut -d\":\" -f1 | sort | uniq -c | sort -n | sed -e 's/^ *//' -e 's/ *\$//'"

# Show open ports
alias openports='netstat -nape --inet'

# Alias's for safe and forced reboots
alias rebootsafe='sudo shutdown -r now'
alias rebootforce='sudo shutdown -r -n now'

# Alias's to show disk space and space used in a folder
alias diskspace="du -S | sort -n -r |more"
alias folders='du -h --max-depth=1'
alias folderssort='find . -maxdepth 1 -type d -print0 | xargs -0 du -sk | sort -rn'
alias tree='tree -CAhF --dirsfirst'
alias treed='tree -CAFd'
alias mountedinfo='df -hT'

# Alias's for archives
alias mktar='tar -cvf'
alias mkbz2='tar -cvjf'
alias mkgz='tar -cvzf'
alias untar='tar -xvf'
alias unbz2='tar -xvjf'
alias ungz='tar -xvzf'

# System aliases
alias pstree='ps axuf'
alias ping='ping -c 10'
alias cls='clear'

#######################################################
# GENERAL ALIAS'S
#######################################################
# To temporarily bypass an alias, we preceed the command with a \
# EG: the ls command is aliased, but to use the normal ls command you would type \ls

# Alias's for multiple directory listing commands
alias la='ls -Alh' # show hidden files
alias ls='ls -aFh --color=always' # add colors and file type extensions
alias lx='ls -lXBh' # sort by extension
alias lk='ls -lSrh' # sort by size
alias lc='ls -lcrh' # sort by change time
alias lu='ls -lurh' # sort by access time
alias lr='ls -lRh' # recursive ls
alias lt='ls -ltrh' # sort by date
alias lm='ls -alh |more' # pipe through 'more'
alias lw='ls -xAh' # wide listing format
alias ll='ls -Fls' # long listing format
alias labc='ls -lap' #alphabetical sort
alias lf="ls -l | egrep -v '^d'" # files only
alias ldir="ls -l | egrep '^d'" # directories only

# Change directory aliases
alias home='cd ~'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Alias's to modified commands
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -Iv'
alias mkdir='mkdir -p'
alias less='less -R'
alias apt-get='sudo apt-get'


# Clean up Python cache
pyclean () {
    find . -type f -name '*.py[co]' -delete -o -type d -name __pycache__ -delete
}

# Switch Google Cloud projects (default project and quota)
gcp-switch-project () {
    if [ -z "$1" ]; then
        echo "Usage: gcp-switch-project <project-id>"
        return 1
    fi
    local PROJECT="$1"
    echo "Switching to project: $PROJECT"
    gcloud auth application-default set-quota-project "$PROJECT"
    gcloud config set project "$PROJECT"
}

# Docker cleanup
docker-cleanup() {
    docker system prune -af --volumes
    echo "Cleaned up all unused containers, networks, images, and volumes"
}

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/andrewjesaitis/projects/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/andrewjesaitis/projects/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/andrewjesaitis/projects/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/andrewjesaitis/projects/google-cloud-sdk/completion.zsh.inc'; fi

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/andrewjesaitis/.cache/lm-studio/bin"
