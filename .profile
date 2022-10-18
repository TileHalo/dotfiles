alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias mlab='matlab -nosplash -nodesktop'

GOPATH="$HOME/go"
PATH="/usr/local/go/bin/:$HOME/.cargo/bin:$HOME/go/bin/:$PATH"
PATH="$HOME/.local/bin/:$HOME/scripts:$PATH"
PATH="$GHCUP_INSTALL_BASE_PREFIX/.ghcup/bin:$PATH"

AURHOME="$HOME/AUR"

if ! command -v nvimpager &> /dev/null; then
	PAGER=nvimpager
fi


HOST=`hostname`
PS1="[ ${HOST} :: ${USER} ] "
export PS1 NVM_DIR GOPATH PATH AURHOME PAGER
