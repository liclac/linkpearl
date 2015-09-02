/home/{{ pillar['deployment']['username'] }}/.ssh:
  file.directory:
    - user: "{{ pillar['deployment']['username'] }}"
    - group: "{{ pillar['deployment']['username'] }}"
    - mode: 700

/home/{{ pillar['deployment']['username'] }}/.ssh/authorized_keys:
  file.append:
    - source: salt://staging/melusine.pub
