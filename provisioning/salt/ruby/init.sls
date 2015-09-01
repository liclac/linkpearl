rbenv-deps:
  pkg.installed:
    - pkgs:
      - libssl-dev
      - libsqlite3-dev

rbenv:
  rbenv.install_rbenv:
    - user: root

ruby-2.2.3:
  rbenv.installed:
    - default: true
    - user: root

/etc/profile.d/rbenv.sh:
  file.managed:
    - source: salt://ruby/rbenv-profile.sh
    - require:
      - rbenv: rbenv

/etc/zsh/zprofile:
  file.append:
    - text: . /etc/profile.d/rbenv.sh
