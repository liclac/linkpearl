redis-server:
  pkg:
    - installed
  service:
    - running
    - enable: true

postgresql:
  pkg:
    - installed
  service:
    - running
    - enable: true

db_user:
  postgres_user.present:
    - name: "{{ pillar['linkpearl']['db_username'] }}"
    - login: true
    - password: "{{ pillar['linkpearl']['db_password'] }}"
    - require:
      - pkg: postgresql

{% for dbname in ['linkpearl', 'linkpearl_development', 'linkpearl_test'] %}
{{ dbname }}:
  postgres_database.present:
    - owner: "{{ pillar['linkpearl']['db_username'] }}"
    - require:
      - pkg: postgresql
{% endfor %}
