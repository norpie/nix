{ pkgs, ... }:

{
  # Automatic flake update and build every day
  # Stores successful builds in flakes/ directory for rollback

  systemd.timers."nixos-auto-update" = {
    description = "Auto-update NixOS flake and build configuration";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      # Run every day at 7 AM
      OnCalendar = "*-*-* 07:00:00";
      Persistent = true;
      Unit = "nixos-auto-update.service";
    };
  };

  systemd.services."nixos-auto-update" = {
    description = "Auto-update NixOS flake and build configuration";
    
    script = ''
      set -e
      set -o pipefail
      
      # Ensure required tools are in PATH
      export PATH="${pkgs.git}/bin:/run/current-system/sw/bin:$PATH"
      
      FLAKE_DIR="/home/norpie/repos/nix"
      FLAKES_DIR="$FLAKE_DIR/flakes"
      LOG_FILE="$FLAKE_DIR/auto-build.log"
      TIMESTAMP=$(${pkgs.coreutils}/bin/date +%Y-%m-%d-%H-%M)
      
      # Function to log with timestamp
      log() {
        echo "[$(${pkgs.coreutils}/bin/date '+%Y-%m-%d %H:%M:%S')] $*" | ${pkgs.coreutils}/bin/tee -a "$LOG_FILE"
      }
      
      # Truncate log to only keep the latest run
      : > "$LOG_FILE"
      
      log "=========================================="
      log "Starting automatic update and build"
      log "=========================================="
      
      # Debug: log environment
      log "DEBUG: PATH=$PATH"
      log "DEBUG: USER=$(${pkgs.coreutils}/bin/whoami)"
      log "DEBUG: PWD=$(${pkgs.coreutils}/bin/pwd)"
      log "DEBUG: HOME=$HOME"
      log "DEBUG: which git: $(which git 2>&1 || echo 'NOT FOUND')"
      log "DEBUG: which nix: $(which ${pkgs.nix}/bin/nix 2>&1 || echo 'NOT FOUND')"
      log "DEBUG: which nh: $(which ${pkgs.nh}/bin/nh 2>&1 || echo 'NOT FOUND')"
      log "DEBUG: which nixos-rebuild: $(which nixos-rebuild 2>&1 || echo 'NOT FOUND')"
      
      # Ensure we're in the right directory
      log "DEBUG: Changing to $FLAKE_DIR"
      cd "$FLAKE_DIR" || { log "ERROR: Failed to cd to $FLAKE_DIR"; exit 1; }
      log "DEBUG: Now in $(${pkgs.coreutils}/bin/pwd)"
      log "DEBUG: flake.lock exists: $(test -f flake.lock && echo yes || echo no)"
      log "DEBUG: flake.nix exists: $(test -f flake.nix && echo yes || echo no)"
      
      # Create flakes directory if it doesn't exist
      ${pkgs.coreutils}/bin/mkdir -p "$FLAKES_DIR"
      
      # Backup current flake.lock before updating
      if [[ -f flake.lock ]]; then
        ${pkgs.coreutils}/bin/cp flake.lock "$FLAKES_DIR/flake.lock.pre-update.$TIMESTAMP"
        log "Backed up current flake.lock"
      fi
      
      # Prepare binaries (add requireFile packages to nix store)
      BIN_DIR="$FLAKE_DIR/bins"
      if [ -d "$BIN_DIR" ] && [ -n "$(${pkgs.coreutils}/bin/ls -A "$BIN_DIR" | ${pkgs.gnugrep}/bin/grep -v .gitkeep)" ]; then
        for bin in "$BIN_DIR"/*; do
          if [ "$(${pkgs.coreutils}/bin/basename "$bin")" != ".gitkeep" ]; then
            log "Adding $bin to nix store"
            ${pkgs.nix}/bin/nix-store --add-fixed sha256 "$bin"
          fi
        done
      else
        log "No binaries found in $BIN_DIR, skipping prepare step"
      fi
      
      # Update flake.lock
      log "Running: ${pkgs.nix}/bin/nix flake update"
      if ${pkgs.nix}/bin/nix flake update 2>&1 | ${pkgs.coreutils}/bin/tee -a "$LOG_FILE"; then
        log "Flake update successful"
      else
        log "ERROR: Flake update failed (exit code: $?)"
        # Restore previous flake.lock
        if [[ -f "$FLAKES_DIR/flake.lock.pre-update.$TIMESTAMP" ]]; then
          ${pkgs.coreutils}/bin/mv "$FLAKES_DIR/flake.lock.pre-update.$TIMESTAMP" flake.lock
          log "Restored previous flake.lock"
        fi
        exit 1
      fi
      
      # Try to build
      HOSTNAME=$(${pkgs.hostname}/bin/hostname)
      log "Running: NIXPKGS_ALLOW_INSECURE=1 nix build .#nixosConfigurations.$HOSTNAME.config.system.build.toplevel --impure --no-link"
      if NIXPKGS_ALLOW_INSECURE=1 ${pkgs.nix}/bin/nix build "$FLAKE_DIR#nixosConfigurations.$HOSTNAME.config.system.build.toplevel" --impure --no-link 2>&1 | ${pkgs.coreutils}/bin/tee -a "$LOG_FILE"; then
        log "Build successful!"
        
        # Store the successful flake.lock
        ${pkgs.coreutils}/bin/cp flake.lock "$FLAKES_DIR/flake.lock.$TIMESTAMP"
        log "Stored successful flake.lock as: flake.lock.$TIMESTAMP"
        
        # Remove the pre-update backup
        ${pkgs.coreutils}/bin/rm -f "$FLAKES_DIR/flake.lock.pre-update.$TIMESTAMP"
        
        # Keep only the last 10 successful builds
        cd "$FLAKES_DIR"
        ${pkgs.coreutils}/bin/ls -t flake.lock.20* 2>/dev/null | ${pkgs.coreutils}/bin/tail -n +11 | ${pkgs.findutils}/bin/xargs -r ${pkgs.coreutils}/bin/rm
        log "Cleaned up old builds (keeping last 10)"
        
        log "=========================================="
        log "Build completed successfully"
        log "=========================================="
        exit 0
      else
        log "ERROR: Build failed (exit code: $?)"
        
        # Restore previous flake.lock
        if [[ -f "$FLAKES_DIR/flake.lock.pre-update.$TIMESTAMP" ]]; then
          ${pkgs.coreutils}/bin/mv "$FLAKES_DIR/flake.lock.pre-update.$TIMESTAMP" flake.lock
          log "Restored previous flake.lock"
        fi
        
        log "=========================================="
        log "Build failed - keeping previous working build"
        log "=========================================="
        exit 1
      fi
    '';
    
    serviceConfig = {
      Type = "oneshot";
      User = "norpie";
      WorkingDirectory = "/home/norpie/repos/nix";
      
      # Allow the service to fail without marking the system as degraded
      SuccessExitStatus = "0 1";
    };
    
    # Don't run if system is on battery (laptop consideration)
    unitConfig = {
      ConditionACPower = true;
    };
  };
}
