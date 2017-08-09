service-nginx:
  service.running:
    - name: nginx
    - require:
      - pkg: nginx
