alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

GOPATH="$HOME/go"
PATH="/usr/local/go/bin/:$HOME/.cargo/bin:/opt/CodeSourcery/arm-2009q1/bin/:$HOME/go/bin/:$PATH"
PATH="/home/leo/.nvm/:$HOME/.local/bin/:$PATH"
TERM="xterm-256color"
PATH="$HOME/.rbenv/bin:$PATH"

NVM_DIR="$HOME/.nvm"

HOST=`hostname`
PS1="[ ${HOST} :: ${USER} ] "
export PS1 NVM_DIR GOPATH PATH TERM
eval "$(rbenv init -)"
. "$NVM_DIR/nvm.sh" # This loads nvm
