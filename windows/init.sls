{% if grains['os'] == 'Windows' %}

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
{% endif %}
