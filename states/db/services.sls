service-mysql:
  service.running:
    - name: mysql
    - enable: True
    - require:
      - pkg: mysql-server
