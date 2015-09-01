elasticsearch:
  pkgrepo.managed:
    - name: deb http://packages.elastic.co/elasticsearch/1.7/debian stable main
    - keyid: 46095ACC8548582C1A2699A9D27D666CD88E42B4
    - keyserver: pgp.mit.edu
  pkg.installed:
    - require:
      - pkgrepo: elasticsearch
  service.running:
    - enable: true
    - require:
      - pkg: elasticsearch
