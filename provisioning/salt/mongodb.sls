mongodb:
  pkgrepo.managed:
    - name: deb http://repo.mongodb.org/apt/debian wheezy/mongodb-org/3.0 main
    - keyid: 7F0CEB10
    - keyserver: keyserver.ubuntu.com
  pkg.installed:
    - name: mongodb-org
    - require:
      - pkgrepo: mongodb
  service.running:
    - name: mongod
    - enable: true
    - require:
      - sls: tuning
      - pkg: mongodb
