include:
  - keepalived.install

keepalived-server:
  file.managed:
    - name: /etc/keepalived/keepalived.conf
    - source: salt://cluster/files/keepalived.conf
    - mode: 644
    - user: root
    - group: root
    - template: jinja
    {% if grains['fqdn'] == 'LVS1' %}
    - ROUTERID: lvs_01
    - STATEID: MASTER
    - PRIORITYID: 150
    {% elif grains['fqdn'] == 'LVS2' %}
    - ROUTERID: lvs_02
    - STATEID: BACKUP
    - PRIORITYID: 100
    {% endif %} 
  service.running:
    - name: keepalived
    - enable: True
    - watch:
      - file: keepalived-server
