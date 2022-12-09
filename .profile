alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias mlab='matlab -nosplash -nodesktop'

if [ -z "$GHCUP_INSTALL_BASE_PREFIX" ]; then
	GHCUP_INSTALL_BASE_PREFIX=$HOME
fi

GOPATH="$HOME/go"
PATH="/usr/local/go/bin/:$HOME/.cargo/bin:$HOME/go/bin/:$PATH"
PATH="$HOME/.local/bin/:$HOME/scripts:$PATH"
PATH="$GHCUP_INSTALL_BASE_PREFIX/.ghcup/bin:$PATH"
PATH="$HOME/comsol/comsol60/multiphysics/bin:$PATH"

AURHOME="$HOME/AUR"

PAGER=nvimpager
KICAD_SYMBOL_DIR="/usr/share/kicad/symbols/"

EDITOR=nvim


HOST=`hostname`
PS1="[ ${HOST} :: ${USER} ] "
export PS1 NVM_DIR GOPATH PATH AURHOME PAGER EDITOR GHCUP_INSTALL_BASE_PREFIX
export KICAD_SYMBOL_DIR
