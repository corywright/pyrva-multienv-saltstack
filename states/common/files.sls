/etc/salt/minion.d/master.conf:
  file.managed:
    - source: salt://common/etc/salt/minion.d/master.conf
    - template: jinja
    - require:
      - pkg: salt-minion
    - watch_in:
      - service: service-salt-minion

/etc/salt/minion.d/settings.conf:
  file.managed:
    - source: salt://common/etc/salt/minion.d/settings.conf
    - require:
      - pkg: salt-minion
    - watch_in:
      - service: service-salt-minion
