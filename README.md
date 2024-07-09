# dotfiles
A moderately alright config for my home directory. Maybe.

#### Linking

For now this repo is cloned over home, or to a directory like `Documents/dots` and symlinked as needed:

```fish
ln -s $PWD/.config/git ~/.config/git
ln -s $PWD/.config/fish/conf.d ~/.config/fish/conf.d
ln -s $PWD/.config/fish/themes ~/.config/fish/themes
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
