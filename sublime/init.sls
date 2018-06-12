{%- from "sublime/map.jinja" import sublime, config with context -%}
{%- set channel = config.get('channel', sublime.channel) -%}

sublime_text_repo:
  pkgrepo.managed:
    - name: deb https://download.sublimetext.com/ apt/{{ channel }}/
    - file: /etc/apt/sources.list.d/sublime-text.list
    - key_url: salt://sublime/files/sublimehq-pub.gpg
    - require_in:
      - sublime-text

sublime_install:
  pkg.latest:
    - pkgs:
      - {{ sublime.package }}
{%- for pkg in sublime.package_dependencies %}
      - {{ pkg }}
{%- endfor %}

{% for usr in config.get('users', '') %}
/home/{{ usr }}/.config/sublime-text-3/Installed Packages/Package Control.sublime-package:
  file.managed:
    - onlyif: test ! -f '/home/{{ usr }}/.config/sublime-text-3/Installed Packages/Package Control.sublime-package'
    - source: salt://sublime/files/Package Control.sublime-package
    - dir_mode: 0750
    - makedirs: True
    - user: {{ usr }}
    - group: {{ usr }}
    - mode: 0640

/home/{{ usr }}/.config/sublime-text-3/Packages/User/Package Control.sublime-settings:
  file.managed:
    - onlyif: test ! -f '/home/{{ usr }}/.config/sublime-text-3/Packages/User/Package Control.sublime-settings'
    - source: {{ config.get('source', sublime.source) }}/Package Control.sublime-settings
    - dir_mode: 0750
    - makedirs: True
    - user: {{ usr }}
    - group: {{ usr }}
    - mode: 0640

/home/{{ usr }}/.config/sublime-text-3/Packages/User/Preferences.sublime-settings:
  file.managed:
    - onlyif: test ! -f /home/{{ usr }}/.config/sublime-text-3/Packages/User/Preferences.sublime-settings
    - source: {{ config.get('source', sublime.source) }}/Preferences.sublime-settings
    - dir_mode: 0750
    - makedirs: True
    - user: {{ usr }}
    - group: {{ usr }}
    - mode: 0640
{% endfor %}
