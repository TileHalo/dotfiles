alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias aalto_remote='xfreerdp ~/school/aalto_remote.rdp /p:$(pass aalto/lahtil2 | head -n1) /f'
alias vim='nvim'

if [ -z "$GHCUP_INSTALL_BASE_PREFIX" ]; then
	GHCUP_INSTALL_BASE_PREFIX=$HOME
fi

function matlab() {
	LD_PRELOAD=/usr/lib/gcc/x86_64-linux-gnu/10/libstdc++.so
	LD_LIBRARY_PATH=/usr/lib/xorg/modules/dri
	/usr/local/bin/matlab
}
function penv() {
	python -m venv venv &&
	source venv/bin/activate
}
function sv() {
    source venv/bin/activate &&
    tmux set-environment VIRTUAL_ENV $VIRTUAL_ENV
}


GOPATH="$HOME/go"
PATH="$HOME/.npm-packages/bin:/usr/local/go/bin:$HOME/.cargo/bin:$HOME/go/bin:$PATH"
PATH="$HOME/.local/bin:$HOME/scripts:$PATH"
PATH="/opt/cisco/anyconnect/bin:$PATH"
MYVIMRC="$HOME/.config/nvim/init.lua"
MYVIMPLUGS="$HOME/.config/nvim/lua/plugins/init.lua"
SSH_AGENT_PID=""
SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/gnupg/S.gpg-agent.ssh"

KICAD_SYMBOL_DIR="/usr/share/kicad/symbols/"

EDITOR=nvim


HOST=`hostname`
PS1="[ ${HOST} :: ${USER} ] "
export PS1 NVM_DIR GOPATH PATH AURHOME EDITOR GHCUP_INSTALL_BASE_PREFIX
export KICAD_SYMBOL_DIR MYVIMRC MYVIMPLUGS SSH_AGENT_PID SSH_AUTH_SOCK

if [ -n "$VIRTUAL_ENV" ]; then
    source $VIRTUAL_ENV/bin/activate;
fi
