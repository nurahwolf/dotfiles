# dotfiles
A moderately alright config for my home directory. Maybe.

#### Linking

For now this repo is cloned over home, or to a directory like `Documents/dots` and symlinked as needed:

```fish
ln -s $PWD/.config/fish/conf.d ~/.config/fish/conf.d
ln -s $PWD/.config/fish/themes ~/.config/fish/themes
ln -s $PWD/.config/git ~/.config/git
ln -s $PWD/.config/htop ~/.config/htop
ln -s $PWD/.config/tmux ~/.config/tmux
```

#### Fish

Most of the fish config is automatic, however, theme changes are manual by design. This allows themes to be set per machine.

Run the following commands to change them locally.

```fish
fish_config theme save "Catppuccin Latte"
fish_config theme save "Catppuccin Frappe"
fish_config theme save "Catppuccin Macchiato"
fish_config theme save "Catppuccin Mocha"
```

#### Tracking Issues

A list of issues or pull requests that impact this repo

- iterm2 and starship
	- [Shell integration is messed up with starship prompt](https://gitlab.com/gnachman/iterm2/-/issues/10537#note_1069174232)
	- [Add support for semantic prompts specification](https://github.com/starship/starship/issues/5463)
	- [feat(module): added iterm2_mark module](https://github.com/starship/starship/pull/3018)

#### Resources

A list of references / resources / credits
- [A list of XDG fixes for troublesome programs](https://wiki.archlinux.org/title/XDG_Base_Directory#Support)
