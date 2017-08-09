salt-master:
  pkg.installed:
    - version: {{ salt.pyrva.conf('salt_version') }}
    - force_yes: True
    - hold: True
    - require:
      - pkg: salt-common
