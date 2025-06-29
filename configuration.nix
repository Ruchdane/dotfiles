# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
      # <home-manager/nixos>
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  hardware.enableAllFirmware  = true;
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.configurationLimit = 1;
  boot.loader.systemd-boot.configurationLimit = 2;
  boot.supportedFilesystems = [ "ntfs" ];
  # fix
  boot.extraModulePackages = with config.boot.kernelPackages;
    [ v4l2loopback.out ];
  boot.kernelModules = [
    "v4l2loopback"
    "snd-aloop"
  ];
  boot.extraModprobeConfig = ''
    options v4l2loopback exclusive_caps=1 card_label="Virtual Camera"
  '';
  boot.kernelParams = [ "pmouse.synaptic_intertouch=0" ];
  
  # boot.kernelPackages = pkgs.linuxPackagesFor (pkgs.linux_6_1.override {
  #   argsOverride = rec {
  #     src = pkgs.fetchurl {
  #           url = "mirror://kernel/linux/kernel/v6.x/linux-${version}.tar.xz";
  #           # sha256 = "0ibayrvrnw2lw7si78vdqnr20mm1d3z0g6a0ykndvgn5vdax5x9a";
  #     };
  #     version = "6.1.92";
  #     modDirVersion = "6.1.92";
  #     };
  # });

  #boot.loader.grub.enable = true;
  #boot.loader.grub.devices = [ "nodev" ];
  #boot.loader.grub.efiInstallAsRemovable = true;
  #boot.loader.grub.efiSupport = true;
  #boot.loader.grub.useOSProber = true;

  networking.hostName = "origin"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Africa/Porto-Novo";

  # boot.kernelPackages = pkgs.linuxPackages_6_6_68;
  # boot.kernelPackages = pkgs.linuxPackagesFor (pkgs.linux_6_1_91);

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver.enable = true;


  services.libinput.enable = true;

  console.keyMap = "fr";

  # Setup Docker
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ruchdane = {
    isNormalUser = true;
    description = "ruchdane";
    extraGroups = [ "networkmanager" "wheel" "docker"];
    shell = pkgs.nushell;
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "ruchdane" = import ./home.nix;
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    anydesk
     appimage-run
     dconf
    
     bluez
     acpi # For battery
     # Browsers
     firefox 
     ungoogled-chromium
     polypane

     # Chat
     teams-for-linux
     telegram-desktop
     discord

     inputs.zen-browser.packages."${system}".default
     figma-linux
     figma-agent
     penpot-desktop
     # Email
     # betterbird

     # Multimedia
     evince #pdf
     vlc
     geeqie 

     # File browser
     mate.caja
    
     # Download manager
     motrix 

     # Screen recording
     obs-studio

     # Dracula 
     dracula-theme
     dracula-icon-theme
     dracula-qt5-theme

     ## 3d 
     blender
    
     ## Image 
     inkscape
     krita
     imagemagick
     
     # Video
     libsForQt5.kdenlive
     ffmpeg

     # Volume control
     kmix

     # Productivity
     libreoffice 
     manuskript
     zettlr
     zotero
     super-productivity
     obsidian

     # Disk usage analyser
     baobab
     
     # Disk partition manager
     gparted
    
     # Menu manager
     rofi
     rofi-obsidian
     rofi-screenshot
     dmenu

     openssl
     arandr
     icu

     ##
     ttyper

     # Game Dev
     godot_4
     ldtk
    
     # Remote Desktop
     remmina

     #networking
     networkmanagerapplet

     # language server
     lua-language-server    # LUA language server
     stylua                 # lua code formatter
                            # helix-gpt
     sqls                   # SQL language server
     nil                    # NIX language server
     astro-language-server  # ASTRO language server
     taplo                  # TOML language server

     # Terminal tools 80% Rust
     wget
     fzf
     git
     lazygit
     lazydocker
     btop
     bat
     fd
     ripgrep
     tree
     p7zip
     gcc
     xclip
     shotgun
     gawk
     pkg-config
     cmatrix
     wluma
    
     zed-editor
     vscode
     vscode.fhs
     # Setup vscode extension     
     helix
     vim 
    
    # File explorer
    mate.caja
    joshuto

    unzip
    zip

    # Setup JS dev Environment
    bun
    prettierd
    nodejs
    typescript
    tailwindcss-language-server
    nodePackages.typescript-language-server
    vscode-langservers-extracted
    superhtml
    emmet-language-server
    corepack

    # Setup dotnet dev Environment
    dotnetCorePackages.sdk_9_0_1xx
    dotnet-sdk
    dotnet-runtime  
    dotnet-aspnetcore
    dotnet-sdk_8
    dotnet-runtime_8
    dotnet-aspnetcore_8
    omnisharp-roslyn
    netcoredbg

    # Setup rust dev Envivronment
    cargo
    rust-analyzer
    bacon
    lldb
    rustc
    rustfmt
    cargo-leptos
    leptosfmt
    cargo-tauri
    trunk
    wasm-pack
    clippy
    pkgs.llvmPackages.bintools
    pre-commit
    rustPackages.clippy
    alsa-lib
    alsa-tools
    libudev-zero
    vulkan-loader
    xorg.libX11
    xorg.libXrandr
    xorg.libXcursor
    xorg.libXi

   # Setup markdown
    marksman
    
    # Setup wine
    wineWowPackages.stable
    winetricks

    # Setup pipewire
    pavucontrol
    helvum

    #nodePackages
    nodePackages.cspell

    skypeforlinux

    texstudio
    texlab
    texlive.combined.scheme-full
    
    (vscode-with-extensions.override {
    vscodeExtensions = with vscode-extensions; [
      bbenoist.nix
      ms-azuretools.vscode-docker
      ms-vscode-remote.remote-ssh
      ms-vscode-remote.remote-containers

      # Web
      bradlc.vscode-tailwindcss
      dbaeumer.vscode-eslint
      esbenp.prettier-vscode

      # C-Sharp
      ms-dotnettools.csharp
      ms-dotnettools.csdevkit

      # Rust
      rust-lang.rust-analyzer

      gruntfuggly.todo-tree
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "vscode-dotnet-runtime";
        publisher = "ms-dotnettools";
        version = "2.0.8";
        sha256 = "SauZ4ISsFPvHDwtUmNetaGzgTxHrl6LVA0kjDGouzmc=";
      }
    ];
  })
];

# Obsidian
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

  # 

  programs.nix-ld.enable = true;
  #JAVA
  programs.java = { enable = true; };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;1
 

  services.xserver = {
    displayManager.lightdm.enable = true; 
    xkb = {
      layout = "fr";
      variant = "azerty";
    };
    windowManager.awesome = {
      enable = true;
      luaModules = with pkgs.luaPackages; [
        luarocks 
        luadbi-mysql 
      ];
    };
  };
  
  # Setup pipewire
  security.rtkit.enable = true;
  services.pipewire = {
   enable = true;
   alsa.enable = true;
   alsa.support32Bit = true;
   pulse.enable = true;
  };
  
  # Setup bluetooth
  services.blueman.enable = true;
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  hardware.bluetooth.settings = {
  	General = {
      Enable = "Source,Sink,Media,Socket";
  		Experimental = true;
  	};
  };

  # hardware.graphics = {
  #   enable = true;
  # };
  # Setup nvidia
  # services.xserver.videoDrivers = ["nvidia"];
  # hardware.nvidia = {
  #     # Modesetting is required.
  #     modesetting.enable = true;

  #     # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
  #     # Enable this if you have graphical corruption issues or application crashes after waking
  #     # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
  #     # of just the bare essentials.
  #     powerManagement.enable = true;

  #     # Fine-grained power management. Turns off GPU when not in use.
  #     # Experimental and only works on modern Nvidia GPUs (Turing or newer).
  #     powerManagement.finegrained = false;

  #     # Use the NVidia open source kernel module (not to be confused with the
  #     # independent third-party "nouveau" open source driver).
  #     # Support is limited to the Turing and later architectures. Full list of 
  #     # supported GPUs is at: 
  #     # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
  #     # Only available from driver 515.43.04+
  #     open = false;

  #     # Enable the Nvidia settings menu,
  # 	# accessible via `nvidia-settings`.
  #     nvidiaSettings = true;

  #     # Optionally, you may need to select the appropriate driver version for your specific GPU.
  #     package = config.boot.kernelPackages.nvidiaPackages.stable;
  #   };
  
    systemd.user.services.mpris-proxy = {
    description = "Mpris proxy";
    after = [ "network.target" "sound.target" ];
    wantedBy = [ "default.target" ];
    serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
  };
  # 24.05
  # services.pipewire.wireplumber.extraConfig = {
  # "monitor.bluez.properties" = {
  #     "bluez5.enable-sbc-xq" = true;
  #     "bluez5.enable-msbc" = true;
  #     "bluez5.enable-hw-volume" = true;
  #     "bluez5.roles" = [ "hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag" ];
  # };
  # 23.11
  environment.etc = {
	"wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
		bluez_monitor.properties = {
			["bluez5.enable-sbc-xq"] = true,
			["bluez5.enable-msbc"] = true,
			["bluez5.enable-hw-volume"] = true,
			["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
		}
	'';
};

  # Setup font
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    nerd-fonts.fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
  ];

  system.autoUpgrade.enable  = true;
  nix.gc = {
    automatic = true;
    randomizedDelaySec = "14m";
    options = "--delete-older-than 1d";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
