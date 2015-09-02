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

{% for user in pillar['gem_users'] %}
bundler-{{ user }}:
  gem.installed:
    - name: bundler
    - user: "{{ user }}"
    - ruby: 2.2.3
{% endfor %}

/etc/profile.d/rbenv.sh:
  file.managed:
    - source: salt://ruby/rbenv-profile.sh
    - require:
      - rbenv: rbenv

/etc/zsh/zprofile:
  file.append:
    - text: . /etc/profile.d/rbenv.sh
