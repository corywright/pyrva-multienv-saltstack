set-vim-as-default-editor:
  cmd.run:
    - name: /usr/bin/update-alternatives --set editor /usr/bin/vim.basic
    - unless: /usr/bin/test "$(update-alternatives --get-selections||awk '/^editor/ {print $3}')" = "/usr/bin/vim.basic"
    - require:
      - pkg: vim
