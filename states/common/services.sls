service-salt-minion:
  service.running:
    - name: salt-minion
    - require:
      - pkg: salt-minion

service-ssh:
  service.running:
    - name: ssh
    - reload: True
    - watch:
      - file: /etc/ssh/sshd_config

service-ntp:
  service.running:
    - name: ntp
