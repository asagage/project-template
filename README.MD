# project-template
A template for creating new projects with Ansible and Vagrant on Ubuntu 16
Table of Contents
-----------------
1. [Description](#description)
1. [Vagrant usage](#vagrant-usage)

Description
------------
This is template for new created repository.
In vagrant file used bento box with ubuntu 16.04.
Box detailed information can be found [here](https://github.com/chef/bento)

Vagrant usage
------------
* Install Vagrant hostmanager plugin
`vagrant plugin install vagrant-hostmanager`
* Open Vagrantfile and change project name
Example:
```ruby
project_name = "template"
```
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
* All custom roles should be created in `roles` folder
* If project required some intalled packages before ansible run, this dependency can be added in shell scrip `vagrant_script/provision.sh`
Example:
```shell
apt-get install python libldap2-dev python-dev libsasl2-dev libssl-dev python-pip
```
* Run `Vagrant up`
