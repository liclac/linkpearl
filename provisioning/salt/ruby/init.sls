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

bundler:
  cmd.run:
    - name: gem install bundler --no-document -i /usr/local/rbenv/versions/2.2.3/lib/ruby/gems/2.2.0/
    - creates: /usr/local/rbenv/versions/2.2.3/bin/bundle
    - require:
      - rbenv: rbenv

/etc/profile.d/rbenv.sh:
  file.managed:
    - source: salt://ruby/rbenv-profile.sh
    - require:
      - rbenv: rbenv

/etc/zsh/zprofile:
  file.append:
    - text: . /etc/profile.d/rbenv.sh
