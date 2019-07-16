{% if grains['os'] == 'CentOS' %}
update cluster nodes:
  cmd.run:
    - name: yum upgrade --exclude="kernel* openafs* *-kmdl-* kmod-* *firmware*" -y

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
{% endif %}



#{% elif grains['os'] == 'Ubuntu' %}
# update cluster nodes:
# cmd.run:
#   - name: |
#       sudo dpkg --configure -a
#       sudo apt-mark hold linux-image-generic linux-headers-generic
#       sudo apt-get update -y
#       sleep 1
#       sudo apt-get upgrade -y
#       sudo apt-mark unhold linux-image-generic linux-headers-generic


#{% endif %}
