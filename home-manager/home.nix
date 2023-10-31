{ pkgs, ... }:

let
  personal = import ./overlay.nix { inherit pkgs; };
in {
  home = {
    username = "hunter";
    homeDirectory = "/home/hunter";
    stateVersion = "23.05";
    packages = with pkgs; [
      personal.dmenu
      lua
      nix-prefetch-github
      unzip
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
      (cargo.overrideAttrs (_: { version = "1.73"; }))
      xclip
      fzf
      fzy
      fd
      bat
      nixfmt
      personal.main-menu
    ];
  };

  fonts.fontconfig.enable = true;

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

    "Pictures/11.png".source = ~/dots/static/11.png;
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
      plugins = [{
        plugin = pkgs.vimPlugins.lazy-nvim;
        # config = ''
        #  packadd! nvim-colorizer.lua
        #  lua require 'colorizer'.setup()
        # '';
      }];
    };

    git = {
      enable = true;
      userName = "head-gardener";
      userEmail = "trashbin2019np@gmail.com";
    };

    kitty = {
      enable = true;
      font = {
        package = personal.lilex;
        name = "Lilex Nerd Font Medium";
      };
      extraConfig = builtins.readFile ~/dots/kitty/kitty.conf;
    };

    fish = {
      enable = true;
      plugins = [
        {
          name = "autopair";
          src =
            fetchGit { url = "https://github.com/jorgebucaran/autopair.fish"; };
        }
        {
          name = "fzf";
          src = fetchGit { url = "https://github.com/PatrickF1/fzf.fish"; };
        }
      ];
    };

    newsboat = {
      enable = true;
      extraConfig = ''
        notify-program "${pkgs.dunst}/bin/dunstify -a 'Newsboat' -u low '%t' '%u'"
      '';
      urls = [{
        title = "Lilex";
        url = "https://github.com/mishamyrt/Lilex/tags.atom";
      }];
    };
  };
}
