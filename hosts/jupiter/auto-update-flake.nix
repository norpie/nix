{ pkgs, ... }:

{
  # Automatic flake update and build every 3 days
  # Stores successful builds in flakes/ directory for rollback
  
  systemd.timers."nixos-auto-update" = {
    description = "Auto-update NixOS flake and build configuration";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      # Run every 3 days at 8 AM
      OnCalendar = "*-*-1,4,7,10,13,16,19,22,25,28,31 08:00:00";
      Persistent = true;
      Unit = "nixos-auto-update.service";
    };
  };

  systemd.services."nixos-auto-update" = {
    description = "Auto-update NixOS flake and build configuration";
    
    script = ''
      set -e
      set -o pipefail
      
      # Ensure git is in PATH
      export PATH="${pkgs.git}/bin:$PATH"
      
      FLAKE_DIR="/home/norpie/repos/nix"
      FLAKES_DIR="$FLAKE_DIR/flakes"
      LOG_FILE="$FLAKE_DIR/auto-build.log"
      TIMESTAMP=$(${pkgs.coreutils}/bin/date +%Y-%m-%d-%H-%M)
      
      # Function to log with timestamp
      log() {
        echo "[$(${pkgs.coreutils}/bin/date '+%Y-%m-%d %H:%M:%S')] $*" | ${pkgs.coreutils}/bin/tee -a "$LOG_FILE"
      }
      
      # Ensure we're in the right directory
      cd "$FLAKE_DIR" || exit 1
      
      log "=========================================="
      log "Starting automatic update and build"
      log "=========================================="
      
      # Create flakes directory if it doesn't exist
      ${pkgs.coreutils}/bin/mkdir -p "$FLAKES_DIR"
      
      # Backup current flake.lock before updating
      if [[ -f flake.lock ]]; then
        ${pkgs.coreutils}/bin/cp flake.lock "$FLAKES_DIR/flake.lock.pre-update.$TIMESTAMP"
        log "Backed up current flake.lock"
      fi
      
      # Update flake.lock
      log "Running nix flake update..."
      if ${pkgs.nix}/bin/nix flake update 2>&1 | ${pkgs.coreutils}/bin/tee -a "$LOG_FILE"; then
        log "Flake update successful"
      else
        log "ERROR: Flake update failed"
        # Restore previous flake.lock
        if [[ -f "$FLAKES_DIR/flake.lock.pre-update.$TIMESTAMP" ]]; then
          ${pkgs.coreutils}/bin/mv "$FLAKES_DIR/flake.lock.pre-update.$TIMESTAMP" flake.lock
          log "Restored previous flake.lock"
        fi
        exit 1
      fi
      
      # Try to build
      log "Running build..."
      if NIXPKGS_ALLOW_INSECURE=1 ${pkgs.nh}/bin/nh os build -- --impure 2>&1 | ${pkgs.coreutils}/bin/tee -a "$LOG_FILE"; then
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
        log "ERROR: Build failed"
        
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
