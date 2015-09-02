app_user:
  user.present:
    - name: "{{ pillar['deployment']['run_as'] }}"
    - gid_from_name: true
    - system: true
    - home: "/var/lib/{{ pillar['deployment']['run_as'] }}"

deployment_user:
  user.present:
    - name: "{{ pillar['deployment']['username'] }}"
    - gid_from_name: true

{{ pillar['deployment']['root'] }}:
  file.directory:
    - user: {{ pillar['deployment']['username'] }}
    - group: {{ pillar['deployment']['username'] }}
    - mode: 755
    - makedirs: true
    - require:
      - user: deployment_user
