# this is needed for the salt mysql checks to work
/etc/salt/minion.d/mysql.conf:
  file.managed:
    - source: salt://db/etc/salt/minion.d/mysql.conf
    - template: jinja
    - mode: 600
    - require:
      - pkg: python-mysqldb
    - watch_in:
      - service: service-salt-minion

# this is common settings for both master and slave servers
/etc/mysql/conf.d/common.cnf:
  file.managed:
    - source: salt://db/etc/mysql/conf.d/common.cnf
    - template: jinja
    - require:
      - pkg: mysql-server
    - watch_in:
      - service: service-mysql-server

{% set role = 'master' if grains.get('role') == 'master' else 'slave' %}
/etc/mysql/conf.d/{{ role }}.cnf:
  file.managed:
    - source: salt://db/etc/mysql/conf.d/{{ role }}.cnf
    - template: jinja
    - require:
      - pkg: mysql-server
    - watch_in:
      - service: service-mysql-server
