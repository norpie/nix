{ pkgs, ... }:
{
  # Load the nct6775 kernel module for hardware monitoring
  boot.kernelModules = [ "nct6775" ];

  # Install lm-sensors for manual control if needed
  environment.systemPackages = with pkgs; [
    lm_sensors
  ];

  # Systemd service to set pump header (pwm7) to manual 50% speed at boot
  systemd.services.fan-control-pump = {
    description = "Set AIO pump header fan to 50% (for hard drives)";
    wantedBy = [ "multi-user.target" ];
    after = [ "systemd-modules-load.service" ];
    
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };

    script = ''
      # Wait for hwmon device to appear
      for i in {1..10}; do
        if [ -e /sys/class/hwmon/hwmon10/pwm7_enable ]; then
          break
        fi
        sleep 1
      done

      # Set pwm7 to manual mode (1) and 50% speed (128/255)
      if [ -e /sys/class/hwmon/hwmon10/pwm7_enable ]; then
        echo "Setting pump header (pwm7) to manual 50% speed..."
        echo 1 > /sys/class/hwmon/hwmon10/pwm7_enable
        echo 128 > /sys/class/hwmon/hwmon10/pwm7
        echo "Fan control applied: pwm7 = 128/255 (50%)"
      else
        echo "ERROR: Could not find /sys/class/hwmon/hwmon10/pwm7_enable"
        exit 1
      fi
    '';
  };
}
