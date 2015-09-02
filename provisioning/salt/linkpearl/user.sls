system_user:
  user.present:
    - name: "{{ pillar['linkpearl']['username'] }}"
    - gid_from_name: true
    - system: true
    - home: "/var/lib/{{ pillar['linkpearl']['username'] }}"
