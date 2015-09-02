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

/home/vagrant/.ssh/id_rsa:
  file.managed:
    - source: salt://staging/id_rsa
    - mode: 600
    - user: vagrant
    - group: vagrant
    - require:
      - file: /home/vagrant/.ssh

/home/vagrant/.ssh/id_rsa.pub:
  file.managed:
    - source: salt://staging/id_rsa.pub
    - mode: 644
    - user: vagrant
    - group: vagrant
    - require:
      - file: /home/vagrant/.ssh

vagrant_db_user:
  postgres_user.present:
    - name: vagrant
    - login: true
    - superuser: true

linkpearl_test_ownership:
  postgres_database.present:
    - name: linkpearl_test
    - owner: vagrant
    - require:
      - sls: linkpearl.database
