deployment_user:
  user.present:
    - name: "{{ pillar['deployment']['username'] }}"
    - gid_from_name: true
