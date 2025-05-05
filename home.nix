{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "ruchdane";
  home.homeDirectory = "/home/ruchdane";
 # imports = [
 #    ./modules/zed.nix
 #  ];

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    (pkgs.writeShellScriptBin "rebuild" ''
      sudo nixos-rebuild switch --flake ~/dotfiles/#default
    '')
    pkgs.lolcat
    pkgs.neofetch
    pkgs.droidcam
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };
  xdg.configFile."awesome".source = ./modules/awesome;
  xdg.configFile."helix".source = ./modules/helix;
  xdg.configFile."alacritty".source = ./modules/alacritty;
  xdg.configFile."zellij".source = ./modules/zellij;


  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/ruchdane/etc/profile.d/hm-session-vars.sh
  home.sessionVariables = {
    EDITOR = "helix";
  };

  services = {
    picom = {
      enable = true;      
      inactiveOpacity = 0.9;
      settings = {
        rounded_corners = true;
        corner-radius = 12;
      };
    };
  };

  gtk = {
    enable = true;
    theme.name = "Dracula";
    cursorTheme.name = "Dracula";
    iconTheme.name = "Dracula";
  };

  qt = {
    enable = true;
    style.name = "Dracula";
  };

  programs = {
    git = {
      enable = true;
      userEmail = "ruchdaneabiodun@gmail.com";
      userName = "ruchdane";
    };

    lazygit = {
      enable = true;
    };

    zellij = {
      enable = true;
    };
    
    vim = {
      enable = true;
      # extraConfig = builtins.readFile vim/vimrc;
      settings = {
         relativenumber = true;
         number = true;
      };
    };

    helix = {
      enable = true;
    };

    alacritty = {
      enable = true;
    };

    nushell = {
      enable = true;
      configFile.source = ./modules/nushell/config.nu;
      envFile.source = ./modules/nushell/env.nu;
      shellAliases = {
        g = "git";
        lzg = "lazygit";
        lzd = "lazydocker";
        zj = "zellij";
      };
    };

    carapace = {
      enable = true;
      enableNushellIntegration = true;
    };


    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableNushellIntegration = true;
    };

    starship = {
       enable = true;
       settings = {
         # add_newline = true;
         # character = {
         #   success_symbol = "[➜](bold green)";
         #   error_symbol = "[➜](bold red)";
         # };
      };
    };

    zed-editor = {
      enable = true;
    };
    home-manager = {
      enable = true;
    };
  };
  # xdg.mimeApps.defaultApplications = {

  # }

}
