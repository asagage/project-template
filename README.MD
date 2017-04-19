# Ansible-iam-management
Table of Contents
-----------------
1. [Description](#description)
1. [Vagrant usage](#vagrant-usage)

Description
------------
This is template for new created repository

Vagrant usage
------------
* Install Vagrant hostmanager plugin
`vagrant plugin install vagrant-hostmanager`
* Additional roles from galaxy should be added in `roles/requirements.yml`
Example:
```yaml
---
 - src: quinot.lookup_ldap
 - src: r_rudi.cowsay
 - src: geerlingguy.git

```
Vagrant will automatically download this roles from galaxy
* To run new role role-name should be added in `main.yml`
Example:
```yaml
---
- hosts: localhost
  roles:
    - bootstrap
    - r_rudi.cowsay
    - quinot.lookup_ldap
    - geerlingguy.git
```
* All community roles dependency should be in bootstrap role `roles/bootstrap`
Example:

```yaml
---
- name: Install apt packages
  apt:
    name: "{{ item }}"
    state: latest
  with_items:
    - software-properties-common
    - python-apt
    - python-pycurl
    - python-pip
    - libldap2-dev
    - python-dev
    - libsasl2-dev
    - libssl-dev

- name: Update all packages to the latest version
  apt:
    upgrade: dist

- name: Install pip packages
  pip:
    name: "{{ item }}"
    state: latest
  with_items:
    - pip
    - jinja2
    - awscli
    - boto
    - boto3
    - python-ldap
```

* All custom roles should be created in `roles` folder
* If project required some intalled packages before ansible run, this dependency can be added in shell scrip `vagrant_script/provision.sh`
Example:
```shell
apt-get install python libldap2-dev python-dev libsasl2-dev libssl-dev python-pip cowsay -y
pip install python-ldap
```
* Run `Vagrant up`
