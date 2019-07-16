{% if grains['os'] == 'CentOS' %}
update cluster nodes:
  cmd.run:
    - name: yum upgarde --exclude="kernel* openafs* *-kmdl-* kmod-* *firmware*" -y
# otherwise update all the things
{% else %}

pkg.upgrade:
  module.run:
    - refresh: True
# reboot if told to, otherwise this will have to be done manually

system.reboot updates:
  module:
    - name: system.reboot
    - run
    - require:
      - module: pkg.upgrade

stops after updates reboot:
  test.fail_without_changes:
    - name: MESSAGE - system rebooting
    - failhard: True
    - require:
      - module: system.reboot updates


{% endif %} # end of os CentOS if

