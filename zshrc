### zsh profiler
if [[ "$ZPROFILE" = 1 ]]; then
    zmodload zsh/zprof
fi


[[ -f ~/.config/zsh/before.zsh ]] && source ~/.config/zsh/before.zsh

# Set default locale to ensure everything is in UTF-8
if [[ -z "$LANG" || "$LANG" == "C" ]]; then
    export LANG='en_AU.UTF-8'
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# PATH {{{1

typeset -U path

if [[ "$(uname)" = "Linux" ]]; then
    path+=(/home/linuxbrew/.linuxbrew/bin)
fi

export GOPATH="$HOME/repos/go"  # `go get` puts stuff here

path+=(
    "$HOME/opt/bin"
    "$HOME/.local/bin"
    "$GOPATH/bin"
)

# export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH" # brew coreutils

# END PATH }}}

# plugin config (antigen) {{{1
# loads zsh completions installed with homebrew
# should be called before compinit
if type brew &>/dev/null; then
    export BREW_PREFIX=$(brew --prefix)
    fpath=($BREW_PREFIX/share/zsh/site-functions $fpath)
fi
fpath=(~/.zfunc /usr/local/share/zsh-completions $fpath)

if [[ -r "$HOME/.local/antigen-repo/antigen.zsh" ]]; then
    source "$HOME/.local/antigen-repo/antigen.zsh"
    # use oh-my-zsh's plugins
    antigen use oh-my-zsh
    antigen bundle git
    antigen bundle safe-paste
    # antigen bundle autojump

    # ignore suggestions with more than one lines
    # NL=$'\n'
    # export ZSH_AUTOSUGGEST_HISTORY_IGNORE="(*$NL*)"
    antigen bundle zsh-users/zsh-completions
    antigen bundle zsh-users/zsh-autosuggestions
    antigen bundle lukechilds/zsh-better-npm-completion

    export YSU_IGNORED_ALIASES=(python v g fsh-alias)
    antigen bundle MichaelAquilina/zsh-you-should-use # prompt for available aliases

    # antigen bundle zsh-users/zsh-syntax-highlighting
    antigen bundle zdharma/fast-syntax-highlighting

    antigen theme romkatv/powerlevel10k

    antigen apply

    # powerlevel10k customizations
    [[ ! -f ~/.config/zsh/p10k.zsh ]] || source ~/.config/zsh/p10k.zsh
fi

# END antigen config }}}

# Display red dots when a tab completion takes long time
COMPLETION_WAITING_DOTS=true

# Disable the (venv) before shell prompt since p10k takes care of it
VIRTUAL_ENV_DISABLE_PROMPT="true"

# Make <C-w> work more intuitively by treating '--dry-run' as a single word
# This has to be set after oh-my-zsh as it changes this variable
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

DISABLE_MAGIC_FUNCTIONS="true"

# Settings & aliases {{{1

[[ "$(uname)" = "Darwin" ]] && TRASH_DIR="$HOME/.Trash/" || TRASH_DIR="$HOME/.local/share/Trash/"

function del () {
    mv "$@" "$TRASH_DIR"
}

if type nvim &> /dev/null; then
    # Use Neovim and nvim remote if installed
    # This prevents nested nvim in git commit etc.
    if [[ -n "$NVIM_LISTEN_ADDRESS" ]]; then
        export VISUAL="nvr -cc tabedit --remote-wait +'set bufhidden=wipe'"
        export MANPAGER="less -is"
    else
        export VISUAL="nvim"
        export MANPAGER='nvim +Man!'
        # export MANWIDTH=80
    fi
    alias v="$VISUAL"
else
    # Use what should be here
    export VISUAL="vim"
fi

export EDITOR="$VISUAL"
export GIT_EDITOR="$VISUAL"

# Less
#   -R Retain colors
#   -i Smartcase search
if [[ ${$(less --version)[2]} -gt 530 ]]; then
    export LESS="--quit-if-one-screen -Ri"
else
    export LESS="-Ri"
fi

# Bat
export BAT_THEME="Nord"

# fzf & ripgrep
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/ripgreprc"
if type fd &> /dev/null; then
    export FZF_DEFAULT_COMMAND="fd --type f"
elif type rg &> /dev/null; then
    export FZF_DEFAULT_COMMAND="rg --files"
else
    export FZF_DEFAULT_COMMAND="find . -type f"
fi

# Emacs
alias e="emacsclient --no-wait --alternate-editor=nvim"
# emacs in terminal
alias et="emacs -nw"

# Delta
export DELTA_PAGER="less $LESS"

# shell builtins
alias la="ls -Ah"
alias lla="ls -lAh"
alias cx="chmod +x"

# git
alias glg="git log --graph --decorate --stat"
alias glo="git log --graph --decorate --oneline"  # Compact view
alias gla="git log --branches --remotes --tags --graph --oneline --decorate"
alias gpr="git pull --rebase"

# ranger
alias ra="ranger"

# fasd: more powerful autojump
alias j="fasd_cd -d"
alias jj="fasd_cd -di"

alias coa="conda activate"
alias cod="conda deactivate"
alias coe="conda info --envs"

# If on macOS, make stat work like Linux
[[ "$(uname)" = "Darwin" ]] && alias stat="stat -x"

# Compilation flags
# export CFLAGS="-Wall -Wextra -Wno-unused-parameter -std=c99"
# export CXXFLAGS="-Wall -Wextra -Wno-unused-parameter -std=c++17"

# LSCOLORS {{{2

# The color designators are as follows:
#       a     black
#       b     red
#       c     green
#       d     brown
#       e     blue
#       f     magenta
#       g     cyan
#       h     light grey
#       A     bold black, usually shows up as dark grey
#       B     bold red
#       C     bold green
#       D     bold brown, usually shows up as yellow
#       E     bold blue
#       F     bold magenta
#       G     bold cyan
#       H     bold light grey; looks like bright white
#       x     default foreground or background

# The order of the attributes are as follows:
#       1.   directory
#       2.   symbolic link
#       3.   socket
#       4.   pipe
#       5.   executable
#       6.   block special
#       7.   character special
#       8.   executable with setuid bit set
#       9.   executable with setgid bit set
#       10.  directory writable to others, with sticky bit
#       11.  directory writable to others, without sticky bit

#                                  1
#                1 2 3 4 5 6 7 8 9 0 1
export LSCOLORS="Gxfxcxdxbxegedabagacad"

# END LSCOLORS }}}2

# Bindings {{{1


# Under iTerm2's CSI u mode, <S-Space> sends '^[[32;2u'. Neovim recognises this by
# default, but zsh doesn't. This maps <S-Space> to enter a space character.
# To find out what code a key combination sends to terminal, enter `sed -n l` in
# terminal and press the key.
bindkey -s '^[[32;2u' ' '

# Alt + f/b to move by word
bindkey '^[f' forward-word
bindkey '^[b' backward-word

# custom functions {{{1
showpath() {
    typeset -p 1 path
}

showcolors() {
    for i in {0..255}; do
        print -Pn "%K{$i} %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%8)):#7}:+$'\n'};
    done
}
# END custom funcitons }}}

# Initialisation scripts {{{1

# Fix slowness of pastes with zsh-syntax-highlighting.zsh {{{2
pasting-self-insert() {
    zle .self-insert
}
pasteinit() {
    OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
    zle -N self-insert pasting-self-insert
}
pastefinish() {
    zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish
# }}}
# fasd
type fasd > /dev/null && eval "$(fasd --init auto)"

# direnv
type direnv &> /dev/null && eval "$(direnv hook zsh)"

# iTerm2 shell integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# fzf
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

# fnm
type fnm > /dev/null && eval "$(fnm env --use-on-cd)"

# libvterm {{{2

vterm_printf(){
    if [ -n "$TMUX" ]; then
        # Tell tmux to pass the escape sequences through
        # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
        printf "\ePtmux;\e\e]%s\007\e\\" "$1"
    elif [ "${TERM%%-*}" = "screen" ]; then
        # GNU screen (screen, screen-256color, screen-256color-bce)
        printf "\eP\e]%s\007\e\\" "$1"
    else
        printf "\e]%s\e\\" "$1"
    fi
} # }}}2

# END Initialisation }}}1

[[ -f ~/.config/zsh/after.zsh ]] && source ~/.config/zsh/after.zsh

# reset the $? variable so it doesn't mess up the prompt
:

### zsh profiler
if [[ "$ZPROFILE" = 1 ]]; then
    zprof
fi

# vim: shiftwidth=4 softtabstop=4 textwidth=0 foldmethod=marker
