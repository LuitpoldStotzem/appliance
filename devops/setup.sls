/etc/apt/sources.list.d/salt.list:
  file.managed:
    - contents: |
        deb https://repo.saltproject.io/py3/debian/10/amd64/archive/3005.1 buster main

include:
  - .software
  - .users
  - .robo3t
  - .postman
  - .hosts
  - .ssh
  - .salt
  - .mongo
  - .desktop
  - .powerlevel9k
  - .zsh
  - .askpass
  - .core4
  #- .core3
