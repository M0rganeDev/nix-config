# dotfiles

Nix config for my computer, powered by home-manager

# Install

first, install home manager as a nixos module, follow this guide : https://nix-community.github.io/home-manager/#sec-install-nixos-module

now, clone the repo in /etc/nixos : 

```
git clone git@github.com:M0rganeDev/nix-config.git /etc/nixos
sudo nixos-rebuild switch
```

note: this config is very personal to me and likely wont work on your machine without editing hardware-configuration.nix.

# Features 

>I3 installed with polybar (todo : move my polybar config to home-manager)

>vim ready to be used for Java, C and C++

>zsh ready to be used

>kitty set up

# Create new user : 

>Install NixOS on your computer (dont do anything fancy, just a standard install without xorg)

>Username must be linuxuser as most scripts are hardcoded to work like that

>backup hardware-configuration.nix

>git clone the repo to your /etc/nixos

>create a new folder in ./hosts

>paste your hardware-configuration.nix

>create your host.nix (make sure it import your hardware-configuration.nix)

>add a new flake entry in flake.nix

>sudo nixos-rebuild switch --flake#/etc/nixos#[your host name] --impure

>reboot

>here you go, you just need to set wallpapers with nitrogen

>after that, you can run `switch [host name]` to update your config
