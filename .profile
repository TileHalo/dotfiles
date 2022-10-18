alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias mlab='matlab -nosplash -nodesktop'

GOPATH="$HOME/go"
PATH="/usr/local/go/bin/:$HOME/.cargo/bin:$HOME/go/bin/:$PATH"
PATH="$HOME/.local/bin/:$HOME/scripts:$PATH"
TERM="st-256color"
AURHOME="$HOME/AUR"

HOST=`hostname`
PS1="[ ${HOST} :: ${USER} ] "
export PS1 NVM_DIR GOPATH PATH TERM MATLAB_JAVA AURHOME

