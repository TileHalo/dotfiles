alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias vim='nvim'

if [ -z "$GHCUP_INSTALL_BASE_PREFIX" ]; then
	GHCUP_INSTALL_BASE_PREFIX=$HOME
fi

function matlab() {
	export LD_PRELOAD=/usr/lib/gcc/x86_64-linux-gnu/10/libstdc++.so
	export LD_LIBRARY_PATH=/usr/lib/xorg/modules/dri;
	/usr/local/bin/matlab
}

GOPATH="$HOME/go"
PATH="/usr/local/go/bin:$HOME/.cargo/bin:$HOME/go/bin:$PATH"
PATH="$HOME/.local/bin:$HOME/scripts:$PATH"
PATH="/opt/cisco/anyconnect/bin:$PATH"

KICAD_SYMBOL_DIR="/usr/share/kicad/symbols/"

EDITOR=nvim


HOST=`hostname`
PS1="[ ${HOST} :: ${USER} ] "
export PS1 NVM_DIR GOPATH PATH AURHOME EDITOR GHCUP_INSTALL_BASE_PREFIX
export KICAD_SYMBOL_DIR
