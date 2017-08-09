{% for site in pillar.get('active_sites') %}
# the document root
/var/www/sites/{{ site }}:
  file.directory:
    - makedirs: True

/etc/nginx/sites-available/{{ site }}.conf:
  file.managed:
    - source: salt://www/etc/nginx/sites-available/{{ site }}.conf
    - template: jinja
    - require:
      - pkg: nginx
      - file: /var/www/sites/{{ site }}

/etc/nginx/sites-enabled/{{ site }}.conf:
  file.symlink:
    - target: /etc/nginx/sites-available/{{ site }}.conf
    - require:
      - file: /etc/nginx/sites-available/{{ site }}.conf
    - watch_in:
      - service: service-nginx

{% endfor %}
