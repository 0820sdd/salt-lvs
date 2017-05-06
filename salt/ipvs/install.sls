/usr/src/linux:
  file.symlink:
    - target: /usr/src/kernels/2.6.32-431.el6.x86_64/

ipvs-install:
  file.managed:
    - name: /home/oldboy/tools/ipvsadm-1.26.tar.gz
    - source: salt://ipvs/files/ipvsadm-1.26.tar.gz
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: cd /home/oldboy/tools && tar zxf ipvsadm-1.26.tar.gz && cd ipvsadm-1.26 && make && make install && modprobe ip_vs
    - unless: test -d /home/oldboy/tools/ipvsadm-1.26
    - require:
      - file: ipvs-install
