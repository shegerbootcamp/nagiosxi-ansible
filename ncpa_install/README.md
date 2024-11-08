## Ansible Role for Nagiosxi NCPA
=================================

Role to install and configure ncpa client

Requirements
------------

None

Role Variables
--------------

Variables definition can be found in the defaults/main folder

Dependencies
------------

None

Example Playbook
----------------

Include this role in your playbook on this way:

```yaml
- hosts: remote
  roles:
    - { role: ../ansible-ncpa, tags: [ ncpa ] }
```

You can get detail results of ncpa from logs:
```bash
tail -f /usr/local/ncpa/var/log/ncpa_*
```
You can run the anisble playbook 

```
ansible-playbook -i tests/inventory tests/test.yml
```
License
-------

Apache-2.0

Author Information
------------------

Jemal M jemalmoh.cloud@gmail.com