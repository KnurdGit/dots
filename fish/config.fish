set fish_greeting
export EDITOR="/usr/bin/code"
#export EDITOR="/usr/bin/nvim"
# SSH Agent and Teleport
## Teleport
abbr -a tshl 'tsh login --ttl=1200 --proxy=teleport.cxense.com:443 --user=vladimirveshkin --login=vladimirveshkin'
abbr -a dt "ln -fF ~/.ssh/config_pure ~/.ssh/config"
abbr -a et "ln -fF ~/.ssh/config_teleport ~/.ssh/config"

## SSH Agent
set -gx SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/ssh-agent.socket"

# Starship integration
starship init fish | source

# locales
set -g LC_CTYPE 'en_US.UTF-8'
set -g LC_ALL 'en_US.UTF-8'


# Aliases

## get current publick IP
abbr -a getip 'curl -4 ifconfig.me'

## apt
abbr -a auad 'sudo apt update && sudo apt dist-upgrade'
abbr -a auac 'sudo apt autoremove && sudo apt autoclean'

## eza
alias ll="eza -l --icons"
alias la="eza -la --icons"
alias lt="eza -l --tree --icons"
alias lat="eza -la --tree --icons"

## xclip
abbr -a xcopy 'xclip -selection clipboard'
abbr -a xpaste 'xclip -selection clipboard -o'

## shellcheck
abbr -a shellcheck 'shellcheck -o all'

## cd
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

## git
abbr -a ggraph "git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
abbr -a gs 'git status -sb'
abbr -a gp 'git pull'
abbr -a gfa 'git fetch --all'
abbr -a gslog "git log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
abbr -a gflog 'git log --all --full-history --'
abbr -a glp 'git log -p'
abbr -a shame 'git blame'

## speedtest
abbr -a st "curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -"

## vagrant
abbr -a vgi 'vagrant init'
abbr -a vup 'vagrant up'
abbr -a vd 'vagrant destroy'
abbr -a vdf 'vagrant destroy -f'
abbr -a vssh 'vagrant ssh'
abbr -a vh 'vagrant halt'
abbr -a vssp 'vagrant suspend'
abbr -a vst 'vagrant status'
abbr -a vre 'vagrant resume'
abbr -a vgs 'vagrant global-status'
abbr -a vpr 'vagrant provision'
abbr -a vr 'vagrant reload'
abbr -a vrp 'vagrant reload --provision'
abbr -a vba 'vagrant box add'
abbr -a vbr 'vagrant box remove'
abbr -a vbl 'vagrant box list'
abbr -a vbo 'vagrant box outdated'
abbr -a vbu 'vagrant box update'

## other
abbr -a sdig 'dig +short'
abbr -a xdig 'dig +short -x'
abbr -a vim_config 'nvim ~/.config/nvim/init.vim'
abbr -a wget 'wget -c' # resume wget download by default

# /config
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

export PATH="/usr/sbin:$PATH"

# rust and cargo
export PATH="$HOME/.cargo/bin:$PATH"

set -g EDITOR nvim

## Add Go binary
export PATH="$HOME/go/bin:$PATH"

## FZF integration
export FZF_DEFAULT_COMMAND='fd'

function fh
    rg "alias.*$argv" ~/.config/fish/config.fish | fzf
end

## Golang to path
export PATH="$PATH:/usr/local/go/bin"

## pyenv
status is-login; and pyenv init --path | source
status is-interactive; and pyenv init - | source

## kubectl crew
set -gx PATH $PATH $HOME/.krew/bin

# # Use bat as man pager
# set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

# Rename tmux pane when connected via ssh
# function ssh
#   if test -n $TMUX
#     tmux rename-window (echo $argv | cut -d . -f 1)
#     command ssh "$argv"
#     tmux set-window-option automatic-rename "on" 1>/dev/null
#   else
#     command ssh "$argv"
#   end
# end
