salt-common:
  pkg.installed:
    - version: {{ salt.pyrva.conf('salt_version') }}

salt-minion:
  pkg.installed:
    - version: {{ salt.pyrva.conf('salt_version') }}
    - require:
      - pkg: salt-common

openssh-server:
  pkg.installed

libsasl2-modules:
  pkg.installed:
    - require_in:
      - pkg: postfix

postfix:
  pkg.installed

ntp:
  pkg.installed

vim:
  pkg.installed

curl:
  pkg.installed
