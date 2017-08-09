/etc/salt/master.d/publisher_acl.conf:
  file.managed:
    - source: salt://salt-master/etc/salt/master.d/publisher_acl.conf
    - watch_in:
      - service: service-salt-master

/etc/salt/master.d/file_roots.conf:
  file.managed:
    - source: salt://salt-master/etc/salt/master.d/file_roots.conf
    - watch_in:
      - service: service-salt-master

/etc/salt/master.d/nodegroups.conf:
  file.managed:
    - source: salt://salt-master/etc/salt/master.d/nodegroups.conf
    - watch_in:
      - service: service-salt-master

/etc/salt/master.d/settings.conf:
  file.managed:
    - source: salt://salt-master/etc/salt/master.d/settings.conf
    - template: jinja
    - watch_in:
      - service: service-salt-master

/srv/salt:
  file.symlink:
    - target: /home/salt/pyrva-multienv-saltstack/states

/srv/pillar:
  file.symlink:
    - target: /home/salt/pyrva-multienv-saltstack/pillar

/srv/files:
  file.symlink:
    - target: /home/salt/pyrva-multienv-saltstack/files
