system_prerequisites:
  pkg.installed:
    - refresh: True
    - pkgs:
      - linux-headers-amd64
      - gcc
      - make
      - perl
      - sudo
      - tmux
      - screen
      - git
      - curl
      - wget
      - mc
      - htop
      - runit
      - runit-systemd
      - zsh
      - python3-dev
      - python3-venv
      - libgconf-2-4
      - build-essential
      - libappindicator3-1
      - meld
      - python-tk
      - libcanberra-gtk-module

nodejs:
  cmd.run:
    - name: |
        curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
        apt-get install -y nodejs
    - creates: /usr/bin/nodejs

yarn:
  cmd.run:
    - name: |
        curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
        echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
        apt --yes update
        apt --yes install yarn
    - creates: /usr/bin/yarn
    - require:
      - cmd: nodejs

github:
  cmd.run:
    - name: |
        curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
        apt --yes update
        apt --yes install gh
    - creates: /etc/apt/sources.list.d/github-cli.list
