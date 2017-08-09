{% set dc = grains.get('dc') %}
base:
  '*':
    - global.users
    - global.secrets
    - global.data
    - global.packages
    # datacenter specific pillar overrides global pillar
    - {{ dc }}.secrets
    - {{ dc }}.data
    - {{ dc }}.packages
