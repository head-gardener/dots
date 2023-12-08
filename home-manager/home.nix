{ pkgs, ... }:

let
  personal = import ./overlay.nix { inherit pkgs; };
  unstable = import <unstable> { overlays = [ ]; };

in {
  home = {
    username = "hunter";
    homeDirectory = "/home/hunter";
    stateVersion = "23.11";
    packages = with pkgs; [
      (personal.main-menu.override { inherit (personal) dmenu; })
      arkpandora_ttf
      bat
      bat
      brightnessctl
      dconf
      fd
      fd
      fish
      fzf
      fzy
      libnotify
      neofetch
      nix-prefetch-github
      personal.cpanel
      personal.dmenu
      pw-volume
      qpwgraph
      tree
      unzip
      vlc
      wineWowPackages.stable
      winetricks
      xclip
    ] ++ [
      entr
      gcc
      haskell-language-server
      julia
      stack
      cabal-install
      lua
      nixfmt
      stack
      unstable.cargo
    ] ++ [
      gimp-with-plugins
      gmic
    ] ++ [
      firefox
      hunspell
      hunspellDicts.ru_RU
      libreoffice
      telegram-desktop
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

    tmux = {
      enable = true;
      # package = unstable.tmux;
      shell = "${pkgs.fish}/bin/fish";
      prefix = "C-a";
      keyMode = "vi";
      mouse = true;
      extraConfig = ''
      '';
    };

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
      shellIntegration.enableFishIntegration = true;
    };

    fish = {
      enable = true;
      interactiveShellInit = ''
        ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
      '';
        # if not set -q TMUX
        #   exec tmux
        # end
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
      urls = [
        {
          title = "Ian Henry";
          url = "https://ianthehenry.com/feed.xml";
        }
        {
          title = "Lilex";
          url = "https://github.com/mishamyrt/Lilex/tags.atom";
        }
      ];
    };
  };
}
