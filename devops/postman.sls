postman_archive:
  archive:
    - if_missing: /opt/postman
    - extracted
    - name: /opt/
    - source: https://dl.pstmn.io/download/latest/linux64
    - source_hash: md5=125c25bcb1bb3a45c19e3513d6190946
    - archive_format: tar
    - tar_options: z
    - keep: true
    - user: root
    - group: root

/usr/local/bin/postman:
  file.symlink:
    - target: /opt/Postman/Postman

/usr/share/applications/postman.desktop:
  file.managed:
    - contents: |
        [Desktop Entry]
        Version=1.0
        Type=Application
        Name=Postman Community Edition
        Icon=/opt/Postman/app/resources/app/assets/icon.png
        Exec="/opt/Postman/app/Postman" %f
        Comment=Postman API Development
        Categories=Development;IDE;
        Terminal=false
