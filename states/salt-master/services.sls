service-salt-master:
  service:
    - name: salt-master
    - running
    - require:
      - pkg: salt-master
