alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias mlab='matlab -nosplash -nodesktop'

GOPATH="$HOME/go"
PATH="/usr/local/go/bin/:$HOME/.cargo/bin:$HOME/go/bin/:$PATH"
PATH="$HOME/.nvm/:$HOME/.local/bin/:$HOME/scripts:$PATH"
TERM="xterm-256color"
PATH="$HOME/.rbenv/bin:$PATH"
PATH="/opt/intelFPGA/20.1/modelsim_ase/bin:$PATH"
AURHOME="$HOME/AUR"

HOST=`hostname`
PS1="[ ${HOST} :: ${USER} ] "
eval "$(rbenv init -)"
if [[ -f "$HOME/.nvm" ]]
then
NVM_DIR="$HOME/.nvm"
. "$NVM_DIR/nvm.sh" # This loads nvm
fi
export PS1 NVM_DIR GOPATH PATH TERM MATLAB_JAVA AURHOME
if [[ -f "/usr/share/nvm/init-nvm.sh" ]]
then
	. /usr/share/nvm/init-nvm.sh
fi

