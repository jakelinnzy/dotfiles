# zsh profiler
# zmodload zsh/zprof
# to use, add `zprof` to end of .zshrc

[ -f ~/.zshrc_before ] && source ~/.zshrc_before

# PATH {{{1

if [ "$(uname)" = "Linux" ]; then
    export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
fi
export PATH="$PATH:/usr/local/sbin"
export PATH="$PATH:$HOME/.cargo/bin" # cargo
export PATH="$PATH:$HOME/opt/bin:$HOME/.local/bin"
export PATH="$HOME/.cabal/bin:$HOME/.ghcup/bin:$PATH" # ghc

# END PATH }}}

# plugin config (antibody) {{{1

# loads zsh completions installed with homebrew
# should be called before compinit
if type brew &>/dev/null; then
    local brew_prefix=$(brew --prefix)
    FPATH="$brew_prefix/share/zsh/site-functions:$FPATH"
fi

ZSH=$(antibody path ohmyzsh/ohmyzsh)
source <(antibody init)

antibody bundle ohmyzsh/ohmyzsh
antibody bundle ohmyzsh/ohmyzsh path:plugins/autojump
antibody bundle ohmyzsh/ohmyzsh path:plugins/git
antibody bundle zsh-users/zsh-syntax-highlighting
antibody bundle zsh-users/zsh-autosuggestions
antibody bundle zsh-users/zsh-completions
antibody bundle MichaelAquilina/zsh-autoswitch-virtualenv
# antibody bundle djui/alias-tips

# - color theme
export TYPEWRITTEN_COLORS='arrow:yellow;symbol:yellow;'\
'symbol_root:magenta;current_directory:cyan;'\
'right_prompt_prefix:242'
export TYPEWRITTEN_GIT_RELATIVE_PATH=false
export TYPEWRITTEN_RIGHT_PROMPT_PREFIX="# "
export TYPEWRITTEN_CURSOR="underscore"  # underscore / terminal
antibody bundle reobin/typewritten

# END antibody config }}}

# Settings {{{1

export EDITOR="nvim"

# Compilation flags
export CFLAGS="-Wall -std=c99"
export CXXFLAGS="-Wall -std=c++14"

# make pkg-config find icu
export PKG_CONFIG_PATH="/usr/local/opt/icu4c/lib/pkgconfig:$PKG_CONFIG_PATH"

# Sets http_proxy, https_proxy, and all_proxy to break GFW
# Comment when not needed
[ -s ~/.export_proxy.zsh ] && source ~/.export_proxy.zsh

# Aliases {{{1
alias v=nvim
alias zshrc="nvim ~/.zshrc"
alias la="ls -Ah"
alias lla="ls -lAh"
alias coa="conda activate"
alias cod="conda deactivate"
alias coe="conda info --envs"
alias glg="git log --graph --decorate --stat"

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


# conda {{{2

# !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/Users/lin/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/Users/lin/opt/anaconda3/etc/profile.d/conda.sh" ]; then
#         . "/Users/lin/opt/anaconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/Users/lin/opt/anaconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup


# iTerm2 shell integration {{{2
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# fzf {{{2
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# END Initialisation }}}1

[ -f ~/.zshrc_after ] && source ~/.zshrc_after

# reset the $? variable so it doesn't mess up the prompt
:


# zsh profiler
# zprof

# vim: shiftwidth=4 softtabstop=4 textwidth=0 foldmethod=marker
