db_user:
  postgres_user.present:
    - name: "{{ pillar['linkpearl']['db_username'] }}"
    - login: true
    - password: "{{ pillar['linkpearl']['db_password'] }}"
    - require:
      - sls: postgres

{% for dbname in ['linkpearl', 'linkpearl_development', 'linkpearl_test'] %}
{{ dbname }}:
  postgres_database.present:
    - owner: "{{ pillar['linkpearl']['db_username'] }}"
    - require:
      - sls: postgres
{% endfor %}
