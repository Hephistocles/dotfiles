# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.dotfiles/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/home/cjol/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="amuse"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git extract cp docker gitignore npm node pip python debian themes z zsh-syntax-highlighting) 

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
alias scrabble="scrabble-helper --language en --letters"
alias tyromerge="git checkout $1 && git fetch && git rebase origin/master && git push --force-with-lease && git checkout master && echo \"merging to $1\" && git merge --no-ff $1 && git push origin master"
alias mytest="_TEST=50 && echo \"My number is $_TEST ok\""
alias k='kubectl'
alias kx='kubectx'
alias kn='kubens'

export GEM_HOME=~/.gem
export PATH=$PATH:$GEM_HOME/bin

NPM_PACKAGES="${HOME}/.npm-packages"

PATH="$NPM_PACKAGES/bin:$PATH"
PATH="${HOME}/.local/bin:$PATH"

# Unset manpath so we can inherit from /etc/manpath via the `manpath` command
unset MANPATH # delete if you already modified MANPATH elsewhere in your config
export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"

# fpath=('~/.dotfiles/.zfunctions' $fpath)
fpath=( ~/.dotfiles/.zfunctions "${fpath[@]}" )

autoload -Uz hello;
autoload -U promptinit;
promptinit

# optionally define some options
PURE_CMD_MAX_EXEC_TIME=10

prompt pure



# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /home/cjol/.npm-packages/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /home/cjol/.npm-packages/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /home/cjol/.npm-packages/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /home/cjol/.npm-packages/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh

export ANDROID_HOME=$HOME/Android/Sdk
export JAVA_HOME=/usr/lib/jvm/jdk1.8.0
export PATH=$PATH:$JAVA_HOME/bin
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

export ARTIFACTORY_USERNAME="christopher.little"
export ARTIFACTORY_PASSWORD="QVA1Qm44dERqdXVQcWhrS1hKdTcyQ1pGZXZW"
export ARTIFACTORY_EMAIL="christopher.little@century.tech"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

