{...}: {
  services.samba = {
    enable = true;
    shares = {
      data = {
        comment = "Data drive";
        path = "/mnt/data";
        validUsers = ["norpie"];
        public = false;
        writable = true;
        printable = false;
        createMask = "0777";
      };
      media = {
        comment = "Media drive";
        path = "/mnt/media";
        validUsers = ["norpie"];
        public = false;
        writable = true;
        printable = false;
        createMask = "0765";
      };
      home = {
        comment = "Home dir";
        path = "/home/norpie";
        validUsers = ["norpie"];
        public = false;
        writable = true;
        printable = false;
        createMask = "0765";
      };
    };
  };
  /*
    [data]
     comment = Data drive
     path = /mnt/data
     valid users = norpie
     public = no
     writable = yes
     printable = no
     create mask = 0777

  [media]
     comment = Media drive
     path = /mnt/media
     valid users = norpie
     public = no
     writable = yes
     printable = no
     create mask = 0765

  [home]
     comment = Home dir
     path = /home/norpie
     valid users = norpie
     public = no
     writable = yes
     printable = no
     create mask = 0765

  [ssd]
     comment = SSD Drive
     path = /mnt/ssd
     valid users = norpie
     public = no
     writable = yes
     printable = no
     create mask = 0765
  */
}
