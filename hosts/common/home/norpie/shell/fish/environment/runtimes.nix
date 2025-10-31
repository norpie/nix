{...}: {
  home.sessionVariables = {
    # Java
    JAVA_HOME = "/usr/lib/jvm/default";
    _JAVA_OPTIONS = "-Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java";
    _JAVA_AWT_WM_NONREPARENTING = "1"; # Fix for Java applications in tiling WMs
  };
}
