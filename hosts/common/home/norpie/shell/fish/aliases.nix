{...}: {
  programs.fish = {
    shellAliases = {
      # Vim aliases
      vi = "vim";
      v = "vim";
      sim = "sudo vim";

      # Custom commands
      Make = "make -C (git root)";
      chmox = "chmod +x";
      monitor-brightness = "xrandr -q | grep ' connected' | awk '{print $1}' | xargs -I {} xrandr --output {} --brightness";
      doc2pdf = "unoconv -f pdf";
      cm = "ccm --plan max5 --timezone Europe/Brussels --time-format 24h";

      # Systemd
      sys = "sudo systemctl";
      usys = "systemctl --user";

      # Synonyms
      quit = "exit";
      background = "wallpaper";

      # Permission aliases
      shutdown = "xorg-state-save && sudo shutdown -h now";
      reboot = "xorg-state-save && sudo reboot";
      sudo = "sudo ";

      # Shorter aliases
      c = "clear";
      b = "back";
      e = "exit";
      q = "quit";

      # Git aliases
      g = "git";
      gc = "git commit";
      gco = "git checkout";
      gcb = "git checkout -b";
      gb = "git branch";
      gd = "git diff";
      gds = "git diff --staged";
      gs = "git status -s";
      gf = "git fetch";
      gl = "git log --oneline --decorate --all --graph";
      ga = "git add";
      gr = "git rm";
      gp = "git push";
      gpl = "git pull --rebase";
      gi = "git ignore";
      gpr = "git pull-request";
      lg = "lazygit";

      # Github
      gh = "gh-dash";

      # Dot aliases
      ds = "dots status";
      dl = "dots log --oneline --decorate --all --graph";
      dc = "dots commit";
      da = "dots add";
      dr = "dots rm";
      dp = "dots push --recurse-submodules=on-demand";
      dpl = "dots pull --rebase --recurse-submodules && dots submodule update --init --recursive";
      dlg = "cd ~ && lazygit -g $HOME/.dots && back";
      di = "dots ignore --dots";

      # Always options
      grep = "grep --color=auto";
      diff = "diff --color=auto";
      rsync = "rsync -avz --progress";
      mkdir = "mkdir -p";
      mv = "mv -v";
      nix-shell = "HISTFILE=/dev/null nix-shell";

      # Bat theme
      bat = "bat --theme='Catppuccin Mocha'";

      # Filetype associations
      pdf = "$PDF_READER";
      url = "$BROWSER";
      txt = "$EDITOR";
      img = "$IMAGE_VIEWER";
      vid = "$VIDEO_PLAYER";

      # JavaScript
      sv = "npx sv";
      n = "npm";
      nr = "npm run dev";

      # Runtimes
      activate = "source .venv/bin/activate";
      dotenv = "source .env";

      # XDG compliance
      wget = "wget --hsts-file $XDG_CONFIG_HOME/wget/wget-hsts";
      mvn = "mvn -gs $XDG_CONFIG_HOME/maven/settings.xml";
      yarn = "yarn --use-yarnrc $XDG_CONFIG_HOME/yarn/config";

      # SSH with XDG paths
      ssh = "ssh -F $XDG_CONFIG_HOME/ssh/config -o UserKnownHostsFile=$HOME/.config/ssh/known_hosts";
      scp = "scp -F $XDG_CONFIG_HOME/ssh/config -o UserKnownHostsFile=$HOME/.config/ssh/known_hosts";
      sshfs = "sshfs -F $HOME/.config/ssh/config -o UserKnownHostsFile=$HOME/.config/ssh/known_hosts";
      ssh-copy-id = "ssh-copy-id -F $XDG_CONFIG_HOME/ssh/config -o UserKnownHostsFile=$HOME/.config/ssh/known_hosts";
    };

    # Conditional aliases using Fish functions
    # These check if commands exist before aliasing
    shellInit = ''
      # Helper function for conditional aliases
      function if_exists_alias
          if command -v $argv[2] > /dev/null 2>&1
              alias $argv[1] $argv[2]
          end
      end

      # Tool preference chain (later ones override earlier ones)
      if_exists_alias code code-insiders

      if_exists_alias top htop
      if_exists_alias top btop
      if_exists_alias top btm

      if_exists_alias fetch neofetch
      if_exists_alias fetch pfetch
      if_exists_alias fetch fastfetch

      if_exists_alias cat bat
      if_exists_alias df duf
      if_exists_alias cp rsync

      # EZA (exa fork) with custom options
      if command -v eza > /dev/null 2>&1
          alias eza "eza --color=always --icons=automatic --git --group-directories-first"
          alias la "eza -l"
          alias l "la -a"
      else
          alias ls "ls -ovHh --color=auto --group-directories-first"
          alias l "ls -ovHhA --color=auto --group-directories-first"
          alias la "ls -ovHha --color=auto --group-directories-first"
      end

      # Vim -> nvim
      if command -v nvim > /dev/null 2>&1
          alias vim nvim
          set -gx VIMINIT "source $XDG_CONFIG_HOME/nvim/init.lua"
      end
    '';
  };
}
