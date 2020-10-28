# My dotfiles backup

Managed with [dotbot](https://github.com/anishathalye/dotbot). To install,
clone the repo and run `./install`. To add a file/directory, move it into the
repo (delete/rename the original), modify `install.conf.yaml`, and run
`./install`.

## Minimal dependencies to get started

Install Neovim 0.5 or above: `brew install --HEAD neovim`

```
brew install autojump bat fd fzf ripgrep node yarn
pip3 install pynvim neovim-remote pylint
```

Environment version management: check [asdf](https://asdf-vm.com) and
[asdf-direnv](https://github.com/asdf-community/asdf-direnv). Install both to
`~/.zshrc-after`.

## Shell prompt

[powerlevel10k](https://github.com/romkatv/powerlevel10k), customizable and
really fast.

> Other themes increase Zsh startup lag -- some by a lot, others by a just a
> little. Powerlevel10k removes it outright.

```
❯ time zsh -i -c exit
zsh -i -c exit  0.09s user 0.08s system 92% cpu 0.191 total
```
