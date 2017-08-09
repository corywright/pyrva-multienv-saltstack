base:
  '*':
    - common.users

{% set datacenters = ('nyc', 'ric', 'sfo', 'dev', 'qa') %}

{% for dc in datacenters %}
{{ dc }}:
  'dc:{{ dc }}':
    - match: grain
    - common
    - common.users
    - common.packages
    - common.files
    - common.services
  'G@dc:{{ dc }} and G@nodetype:api':
    - match: compound
    - api
    - api.packages
    - api.files
    - api.services
  'G@dc:{{ dc }} and G@nodetype:db':
    - match: compound
    - db
    - db.packages
    - db.files
    - db.services
  'G@dc:{{ dc }} and G@nodetype:salt-master':
    - match: compound
    - salt-master
    - salt-master.packages
    - salt-master.files
    - salt-master.services
  'G@dc:{{ dc }} and G@nodetype:www':
    - match: compound
    - www
    - www.packages
    - www.files
    - www.services
