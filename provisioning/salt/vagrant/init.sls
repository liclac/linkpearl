/home/vagrant/.ssh:
  file.directory:
    - user: vagrant
    - group: vagrant
    - mode: 700

/home/vagrant/.ssh/config:
  file.managed:
    - source: salt://vagrant/ssh_config
    - template: jinja
    - user: vagrant
    - group: vagrant
    - require:
      - file: /home/vagrant/.ssh

/home/vagrant/.ssh/melusine:
  file.managed:
    - source: salt://staging/melusine
    - mode: 600
    - user: vagrant
    - group: vagrant
    - require:
      - file: /home/vagrant/.ssh

/home/vagrant/.ssh/melusine.pub:
  file.managed:
    - source: salt://staging/melusine.pub
    - mode: 644
    - user: vagrant
    - group: vagrant
    - require:
      - file: /home/vagrant/.ssh
