{ config, pkgs, ... }:

{
  home.username = "hunter";
  home.homeDirectory = "/home/hunter";
  home.stateVersion = "23.05";
  home.packages = with pkgs; [ 
    julia
    flowblade
    gimp
    gmic
    wineWowPackages.stable
    winetricks
    libreoffice
    hunspell
    hunspellDicts.ru_RU
    firefox
    tree
    fish
    neofetch
    telegram-desktop
    vlc
    gcc
    (cargo.overrideAttrs (_: {version = "1.73";}))
    xclip
    fzf
    fzy
    fd
    bat
  ];

  gtk = {
    enable = true;
    theme = {
      name = "Graphite";
      package = pkgs.graphite-gtk-theme;
    };
  };

  home.file = {
    ".config/nvim".source = ~/dots/nvim;
    ".config/nvim".recursive = true;

    ".config/i3/config".source = ~/dots/i3/config;

    ".config/fish".source = ~/dots/fish;
    ".config/fish".recursive = true;

    ".config/picom.conf".source = ~/dots/picom.conf;
  };

  home.sessionVariables = { };

  programs = {
    home-manager.enable = true;
    
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;

      # extraLuaConfig = lib.fileContents /home/hunter/config/nvim/init.lua;
      plugins = [
        {
          plugin = pkgs.vimPlugins.lazy-nvim;
          # config = ''
          #  packadd! nvim-colorizer.lua
          #  lua require 'colorizer'.setup()
          # '';
        }
      ];
    };

    git = {
      enable = true;
      userName  = "head-gardener";
      userEmail = "trashbin2019np@gmail.com";
    };

    fish = {
      enable = true;
      shellInit = ''
        set fish_function_path $fish_function_path ~/Source/plugin-foreign-env/functions
        fenv export COCK=cock
      '';
      plugins = [
        {
          name = "autopair";
          src = fetchGit { 
            url = "https://github.com/jorgebucaran/autopair.fish";
          };
        }
        {
          name = "fzf";
          src = fetchGit { 
            url = "https://github.com/PatrickF1/fzf.fish";
          };
        }
      ];
    };
  };
}
