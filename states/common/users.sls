add-group-pyrva:
  group.present:
    - name: pyrva

{% for user in pillar.get('users') %}
add-user-{{ user }}:
  user.present:
    - name: {{ user }}
    - home: /home/{{ user }}
    - shell: /bin/bash
    - gid_from_name: True
    - remove_groups: False
    - groups:
      - pyrva
    - require:
      - group: add-group-pyrva

/home/{{ user }}:
  file.recurse:
    - source: salt://common/home/{{ user }}
    - user: {{ user }}
    - group: {{ user }}
    - template: jinja
    - exclude_pat: .ssh/authorized_keys
    - require:
      - user: {{ user }}

/home/{{ user }}/.ssh:
  file.directory:
    - mode: 700
    - user: {{ user }}
    - group: {{ user }}
    - require:
      - file: /home/{{ user }}

/home/{{ user }}/.ssh/authorized_keys:
  file.managed:
    - source: salt://common/home/{{ user }}/.ssh/authorized_keys
    - user: {{ user }}
    - group: {{ user }}
    - require:
      - file: /home/{{ user }}/.ssh
    - mode: 600
{% endfor %}
