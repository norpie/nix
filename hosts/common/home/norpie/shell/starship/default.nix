{...}: {
  programs.starship = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      # Two-line prompt
      format = "$username at $hostname in $directory$git_branch$line_break$time $character";

      # Add newline between prompts
      add_newline = true;

      # Username
      username = {
        style_user = "bold #ffafff";
        style_root = "bold red";
        format = "[$user]($style)";
        disabled = false;
        show_always = true;
      };

      # Hostname
      hostname = {
        ssh_only = false;
        format = "[$hostname]($style)";
        style = "bold #ffafff";
        disabled = false;
      };

      # Directory - show repo-name/subdir when in git, otherwise full path
      directory = {
        format = "[$path]($style)";
        style = "bold #ffafff";
        truncation_length = 100;
        truncate_to_repo = false;
      };

      # Git branch
      git_branch = {
        format = " on [$branch]($style)";
        style = "bold #ffafff";
      };

      # Hide git status symbols (we just want branch name)
      git_status = {
        disabled = true;
      };

      # Time
      time = {
        disabled = false;
        format = "[$time]($style)";
        style = "white";
        time_format = "%H:%M";
      };

      # Character (the prompt symbol with vi mode support)
      character = {
        success_symbol = "[<I>](bold green)";            # Insert mode (like Vim)
        error_symbol = "[<I>](bold red)";                # Insert mode with error
        # Vi mode symbols (matching Vim colors)
        vicmd_symbol = "[<N>](bold blue)";               # Normal mode
        vimcmd_visual_symbol = "[<V>](bold purple)";     # Visual mode
        vimcmd_replace_symbol = "[<R>](bold red)";       # Replace mode
        vimcmd_replace_one_symbol = "[<R>](bold red)";   # Replace one mode
      };
    };
  };
}
