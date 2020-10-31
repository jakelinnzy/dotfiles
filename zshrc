# zsh profiler
# zmodload zsh/zprof
# to use, add `zprof` to end of .zshrc

[ -f ~/.zshrc_before ] && source ~/.zshrc_before

# PATH {{{1

if [ "$(uname)" = "Linux" ]; then
    export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
fi
export PATH="$PATH:/usr/local/sbin"
export PATH="$PATH:$HOME/opt/bin:$HOME/.local/bin"
export PATH="$PATH:$HOME/.cargo/bin" # cargo
export PATH="$HOME/.cabal/bin:$HOME/.ghcup/bin:$PATH" # ghc

# END PATH }}}

# plugin config (antigen) {{{1

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# loads zsh completions installed with homebrew
# should be called before compinit
if type brew &>/dev/null; then
    local brew_prefix=$(brew --prefix)
    fpath=($brew_prefix/share/zsh/site-functions $fpath)
fi
fpath=(~/.zfunc /usr/local/share/zsh-completions $fpath)

source "$HOME/.local/antigen.zsh"


# use oh-my-zsh's plugins
antigen use oh-my-zsh
antigen bundle git
antigen bundle autojump

antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle lukechilds/zsh-better-npm-completion
antigen bundle MichaelAquilina/zsh-autoswitch-virtualenv
antigen bundle MichaelAquilina/zsh-you-should-use
antigen bundle zsh-users/zsh-syntax-highlighting

antigen theme romkatv/powerlevel10k

antigen apply

# powerlevel10k customizations
[[ ! -f ~/.config/zsh/p10k.zsh ]] || source ~/.config/zsh/p10k.zsh

# END antigen config }}}

# Settings & aliases {{{1

# Neovim (nvim remote)
# This prevents nested nvim in git commit etc.
if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
    export VISUAL="nvr -cc tabedit --remote-wait +'set bufhidden=wipe'"
    export MANPAGER="less -is"
else
    export VISUAL="nvim"
    export MANPAGER='nvim +Man!'
    export MANWIDTH=80
fi
export EDITOR="$VISUAL"
export GIT_EDITOR="$VISUAL"
alias v="$VISUAL"

# Emacs
alias e="emacsclient --no-wait --alternate-editor=nvim"
# emacs in terminal
alias et="emacs -nw"

# Compilation flags
export CFLAGS="-Wall -Wextra -Wno-unused-parameter -std=c99"
export CXXFLAGS="-Wall -Wextra -Wno-unused-parameter -std=c++17"

# make pkg-config find icu
export PKG_CONFIG_PATH="/usr/local/opt/icu4c/lib/pkgconfig:$PKG_CONFIG_PATH"

# fzf & ripgrep
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/ripgreprc"
export FZF_DEFAULT_COMMAND="rg --files"

alias la="ls -Ah"
alias lla="ls -lAh"
alias coa="conda activate"
alias cod="conda deactivate"
alias coe="conda info --envs"
alias glg="git log --graph --decorate --stat"

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
    echo $PATH | sed $'s/:/\\\n/g'
}

showcolors() {
    for i in {0..255}; do
        print -Pn "%K{$i} %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%8)):#7}:+$'\n'};
    done
}
# END custom funcitons }}}

# Initialisation scripts {{{1
# Fix slowness of pastes with zsh-syntax-highlighting.zsh {{{2
pasteinit() {
    OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
    zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

pastefinish() {
    zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish


# iTerm2 shell integration {{{2
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# fzf {{{2
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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
}


# END Initialisation }}}1

[ -f ~/.zshrc_after ] && source ~/.zshrc_after

# reset the $? variable so it doesn't mess up the prompt
:

# zsh profiler
# zprof

# vim: shiftwidth=4 softtabstop=4 textwidth=0 foldmethod=marker
