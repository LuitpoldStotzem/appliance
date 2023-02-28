pycharm:
  archive:
    - if_missing: /opt/pycharm-community-2022.3.2
    - extracted
    - name: /opt/
    - source: https://download-cf.jetbrains.com/python/pycharm-community-2022.3.2.tar.gz
    - source_hash: md5=dcaf746d38ba0582d830aeba63f26ec7
    - archive_format: tar
    - tar_options: z
    - enforce_toplevel: False
    - keep: true
    - user: root
    - group: root

/opt/pycharm:
  cmd.run:
    - name: |
        test -d /opt/pycharm-community-2022.3.2 && ln -s /opt/pycharm-community-2022.3.2 /opt/pycharm && exit
    - unless: test -h /opt/pycharm

/usr/local/bin/pycharm:
  file.symlink:
    - target: /opt/pycharm/bin/pycharm.sh

/usr/share/applications/jetbrains-pycharm-ce.desktop:
  file.managed:
    - contents: |
        [Desktop Entry]
        Version=1.0
        Type=Application
        Name=PyCharm Community Edition
        Icon=/opt/pycharm/bin/pycharm.svg
        Exec="/opt/pycharm/bin/pycharm.sh" %f
        Comment=Python IDE for Professional Developers
        Categories=Development;IDE;
        Terminal=false
        StartupWMClass=jetbrains-pycharm-ce
