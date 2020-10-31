# My dotfiles backup

Managed with [dotbot](https://github.com/anishathalye/dotbot). To install,
clone the repo and run `./install`. To add a file/directory, move it into the
repo (delete/rename the original), modify `install.conf.yaml`, and run
`./install`.

## Minimal dependencies to get started

Install Neovim 0.5 or above:
```
# homebrew
brew install --HEAD neovim

# apt
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update
sudo apt install -y neovim
```

Other tools:
```
# homebrew
brew install autojump bat fd fzf ripgrep git node yarn

# apt
sudo apt install -y autojump curl fzf ripgrep npm python3-pip python3-pynvim zsh

pip3 install pynvim neovim-remote pylint
npm install -g neovim
```

Environment version management: check [asdf](https://asdf-vm.com) and
[asdf-direnv](https://github.com/asdf-community/asdf-direnv). Install both to
`~/.zshrc_after`.

## Vim

The vimrc is meant to be used with Neovim 0.5+, although it also works on
Vim with some plugins disabled.

Some settings I really like:

- Use `,` and `m` for scrolling.
    ```
    noremap , <C-u>
    noremap m <C-d>
    ```
- `Alt + h/j/k/l` moves cursor between split windows in any mode.
- Use space bar as the leader key and have logical mappings.

## Shell prompt

[powerlevel10k](https://github.com/romkatv/powerlevel10k), customizable and
really fast.

> Other themes increase Zsh startup lag -- some by a lot, others by a just a
> little. Powerlevel10k removes it outright.
```
❯ time zsh -i -c exit
zsh -i -c exit  0.09s user 0.08s system 92% cpu 0.191 total
```

## Emacs

See `doom-emacs/README-doom.org`
