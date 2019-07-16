{% if grains['os'] == 'CentOS' %}
update cluster nodes:
 cmd.run:
   - name: yum upgrade --exclude="kernel* openafs* *-kmdl-* kmod-* *firmware*" -y

{% elif grains['os'] == 'Ubuntu' %}
update cluster nodes:
 cmd.run:
   - name: |
      sudo dpkg --configure -a
      sudo apt-mark hold linux-image-generic linux-headers-generic
      sudo apt-get update -y
      sudo apt-get upgrade -y
      sudo apt-mark unhold linux-image-generic linux-headers-generic

{% elif grains['os'] == 'Windows' %}

# Install a single update using the KB
KB3194343:
 wua.installed

# Install a single update using the name parameter
install_update:
 wua.installed:
   - name: KB3194343

# Install multiple updates using the updates parameter and a combination of
# KB number and GUID
install_updates:
 wua.installed:
  - updates:
    - KB3194343
    - bb1dbb26-3fb6-45fd-bb05-e3c8e379195c
    - update all packages
# cmd.run:
#   - name: update all packages
update_system:
  wua.uptodate

# Update the drivers
update_drivers:
  wua.uptodate:
    - software: False
    - drivers: True
    - skip_reboot: False

# Apply all critical updates
update_critical:
  wua.uptodate:
    - severities:
      - Critical
{% endif %}
