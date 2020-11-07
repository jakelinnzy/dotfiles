# My dotfiles backup

Managed with [dotbot](https://github.com/anishathalye/dotbot). To install, clone the repo and run `./install`. To add a file/directory, move it into the repo (delete/rename the original), modify `install.conf.yaml`, and run `./install`.

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
brew install autojump bat fd fzf ripgrep git node yarn git-delta

# apt
sudo apt install -y autojump curl fzf ripgrep npm python3-pip python3-pynvim zsh

pip3 install pynvim neovim-remote pylint
npm install -g neovim
```

Environment version management: check [asdf](https://asdf-vm.com) and [asdf-direnv](https://github.com/asdf-community/asdf-direnv). Configure both in `~/.zshrc_after`.

Homebrew provides a way to save all installed packages (including cask) to a file. Run `brew bundle dump`.

To install all packages with Homebrew, run (this may take a while)
```
brew bundle --file=./Brewfile
```

## Emacs

See [doom-emacs/config.org](doom-emacs/config.org).

Installing Doom Emacs is really slow. To quickly start working, use Vim / Neovim instead.

## Shell prompt

[powerlevel10k](https://github.com/romkatv/powerlevel10k), customizable and really fast.

> Other themes increase Zsh startup lag -- some by a lot, others by a just a
> little. Powerlevel10k removes it outright.
```
❯ time zsh -i -c exit
zsh -i -c exit  0.09s user 0.08s system 92% cpu 0.191 total
```

## Vim

The vimrc is meant to be used with Neovim 0.5+, although it also works on Vim 8 with some plugins disabled.

Some highlights:

- Use `,` and `m` for scrolling. Way more ergonomic than pressing `C-d` and `C-u` repeatedly.
    ```
    noremap , <C-u>
    noremap m <C-d>
    ```
- `Alt + h/j/k/l` moves cursor between split windows.
- Use space bar as the leader key.

## Useful programs

- [delta](https://github.com/dandavison/delta): efficient and enjoyable git diff viewer
