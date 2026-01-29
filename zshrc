# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Theme
ZSH_THEME="andrewjesaitis"

# Better directory navigation
setopt LIST_AMBIGUOUS      # List ambiguous completions
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
plugins=(colored-man-pages sudo colorize history python macos terraform uv fzf gcloud docker docker-compose)

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

#######################################################
# ALIASES
#######################################################

# General
alias cat='bat '
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -Iv'
alias mkdir='mkdir -p'
alias less='less -R'
alias cls='clear'
alias home='cd ~'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# List (macOS compatible flags)
alias la='ls -Alh'                     # show hidden files
alias ls='ls -GFh'                     # add colors (-G) and file type extensions (-F)
alias lx='ls -lXBh'                    # sort by extension
alias lk='ls -lSrh'                    # sort by size
alias lc='ls -lcrh'                    # sort by change time
alias lu='ls -lurh'                    # sort by access time
alias lr='ls -lRh'                     # recursive ls
alias lt='ls -ltrh'                    # sort by date
alias lm='ls -alh | more'              # pipe through 'more'
alias lw='ls -xAh'                     # wide listing format
alias ll='ls -Fls'                     # long listing format
alias labc='ls -lap'                   # alphabetical sort
alias lf="ls -l | egrep -v '^d'"       # files only
alias ldir="ls -l | egrep '^d'"        # directories only

# Disk Usage (macOS compatible flags)
alias diskspace="du -S | sort -n -r | more"
alias folders='du -h -d 1'
alias folderssort='find . -maxdepth 1 -type d -print0 | xargs -0 du -sk | sort -rn'
alias tree='tree -CAhF --dirsfirst'
alias treed='tree -CAFd'
alias mountedinfo='df -hT'

# Network
# 'netstat -nape' is Linux specific. macOS equivalent is often 'lsof -i' or 'netstat -anv'
alias openports='sudo lsof -i -P -n | grep LISTEN'
alias ipview="netstat -an | grep .80 | awk {'print \$5'} | cut -d\".\" -f1-4 | sort | uniq -c | sort -n"
alias ping='ping -c 10'

# System
alias pstree='ps axuf'
alias rebootsafe='sudo shutdown -r now'
alias rebootforce='sudo shutdown -r -n now'

# Archives
alias mktar='tar -cvf'
alias mkbz2='tar -cvjf'
alias mkgz='tar -cvzf'
alias untar='tar -xvf'
alias unbz2='tar -xvjf'
alias ungz='tar -xvzf'

# Git
alias got='git '
alias get='git '

# Docker
alias docker_kill_all='docker kill $(docker ps -q)'
alias docker_rm_all='docker rm $(docker ps -a -q)'
alias docker_rmi_all='docker rmi $(docker images -q)'

# Virtual Env
alias mkvenv='python3 -m venv .venv && source .venv/bin/activate'
alias rmvenv='rm -rf .venv && deactivate'
alias svenv='source .venv/bin/activate'

# GCP
alias gcp-login='gcloud auth application-default login'
alias gcp-logout='gcloud auth revoke'
alias gcp-list-projects='gcloud projects list'
alias gcp-current-project='gcloud config list --format="value(core.project)"'
alias gcp-cloud-sql-proxy-pims-dev='cloud-sql-proxy --address 0.0.0.0 --port 1234 pims-developer:us-central1:pims-dev-postgres'
alias gcp-cloud-sql-proxy-pims-prod='cloud-sql-proxy --address 0.0.0.0 --port 1234 pims-production:us-central1:pims-prod-postgres'
alias gcp-cloud-sql-proxy-profluent-evo='cloud-sql-proxy --address 127.0.0.1 --port 3306 profluent-evo:us-central1:profluent-evo'
alias gcp-cloud-sql-proxy-profluent-evo-dev='cloud-sql-proxy --address 127.0.0.1 --port 3306 profluent-evo-dev:us-central1:profluent-evo'
alias gcp-artifact-registry-credentials='export USERNAME=oauth2accesstoken && export PASSWORD=$(gcloud auth application-default --project profluent-core print-access-token) && export UV_INDEX_PRIVATE_REGISTRY_USERNAME=$USERNAME && export UV_INDEX_PRIVATE_REGISTRY_PASSWORD=$PASSWORD'
alias gcp-export-adc='export GOOGLE_APPLICATION_CREDENTIALS=$HOME/.config/gcloud/application_default_credentials.json'

#######################################################
# FUNCTIONS
#######################################################

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

#######################################################
# CURRENTLY TESTING - Modern CLI tools
#######################################################

# zoxide - smarter cd that learns your habits
# Usage: z dirname (jumps to most frecent match)
eval "$(zoxide init zsh)"

# eza - modern ls replacement with icons and git status
alias ls='eza'
alias ll='eza -l --git'
alias la='eza -la --git'
alias lt='eza -lT --git'           # tree view
alias tree='eza --tree'
