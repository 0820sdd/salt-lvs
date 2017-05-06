include:
  - pkg.init

nginx-install:
  file.managed:
    - name: /home/oldboy/tools/nginx-1.6.3.tar.gz
    - source: salt://nginx/files/nginx-1.6.3.tar.gz
    - mode: 755
    - user: root
    - group: root
  user.present:
    - name: nginx
    - createhome: False
    - gid_from_name: True
    - shell: /sbin/nologin
  cmd.run:
    - name: cd /home/oldboy/tools && tar xf nginx-1.6.3.tar.gz && cd nginx-1.6.3 && ./configure --user=nginx --group=nginx --prefix=/application/nginx-1.6.3/ --with-http_stub_status_module --with-http_ssl_module && make && make install
    - unless: test -d /application/nginx-1.6.3/
    - require:
      - file: nginx-install

/application/nginx:
  file.symlink:
    - target: /application/nginx-1.6.3
