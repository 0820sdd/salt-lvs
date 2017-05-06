keepalived-install:
  file.managed:
    - name: /usr/local/src/keepalived-1.1.19.tar.gz
    - source: salt://keepalived/files/keepalived-1.1.19.tar.gz
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: cd /usr/local/src && tar zxf keepalived-1.1.19.tar.gz && cd keepalived-1.1.19 && ./configure --prefix=/usr/local/keepalived && make && make install 

keepalived-init:
  file.managed:
    - name: /etc/init.d/keepalived
    - source: salt://keepalived/files/keepalived.init
    - user: root
    - group: root
    - mode: 755

keepalived-sysconfig:
  file.managed:
    - name: /etc/sysconfig/keepalived
    - source: salt://keepalived/files/keepalived.sysconfig
    - user: root
    - group: root
    - mode: 644

/etc/keepalived:
  file.directory:
    - user: root
    - group: root
    - dir_mode: 755
    - file_mode: 644

keepalived-init.d:
  cmd.run:
    - name: chkconfig --add keepalived
    - unless: chkconfig --list | grep keepalived
    - require:
      - file: keepalived-init

/usr/sbin/keepalived:
  file.symlink:
    - target: /usr/local/keepalived/sbin/keepalived    
