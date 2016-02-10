# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Theme
export VIRTUAL_ENV_DISABLE_PROMPT=1
ZSH_THEME="andrewjesaitis"

setopt list_ambiguous

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Update Oh my zsh every month
# export UPDATE_ZSH_DAYS=30

# Oh my zsh plugins
plugins=(colored-man git python)

# Oh my zsh setup magic
source $ZSH/oh-my-zsh.sh

# My Path through the technological woods
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/sbino:$PATH

#Virtualenv and python stuff
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Projects
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python
source /usr/local/bin/virtualenvwrapper.sh

#Sane db aliases
alias rs='python manage.py runserver'
alias start_mysql='mysql.server start'
alias stop_mysql='mysql.server stop'

alias start_mongo="mongod --dbpath ~/Projects/mongodatabases"
alias stop_mongo="mongo --eval \"db.getSiblingDB('admin').shutdownServer()\""

alias start_postgres='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias stop_postgres='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log stop'

alias restart_couch='/usr/bin/sudo launchctl stop org.apache.couchdb'
alias start_couch='/usr/bin/sudo launchctl load -w /Library/LaunchDaemons/org.apache.couchdb.plist'
alias stop_couch='/usr/bin/sudo launchctl unload /Library/LaunchDaemons/org.apache.couchdb.plist'

#Git aliases
alias got='git '
alias get='git '

#Perhaps you should include this apple, hmmmm....
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

source ~/Dropbox/secrets
