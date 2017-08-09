/etc/nginx/sites-available/api.example.com.conf:
  file.managed:
    - source: salt://www/etc/nginx/sites-available/api.example.com.conf
    - template: jinja
    - require:
      - pkg: nginx
      - file: /var/www/sites/api.example.com

/etc/nginx/sites-enabled/api.example.com.conf:
  file.symlink:
    - target: /etc/nginx/sites-available/api.example.com.conf
    - require:
      - file: /etc/nginx/sites-available/api.example.com.conf
    - watch_in:
      - service: service-nginx
