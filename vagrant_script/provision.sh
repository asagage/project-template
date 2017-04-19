#!/usr/bin/env bash

export PYTHONUNBUFFERED=1
export ANSIBLE_FORCE_COLOR=1
set -x
# Only run through the full install if Ansible hasn't been installed yet
echo "Configuring the Server:"
export DEBIAN_FRONTEND=noninteractive

echo "  1/7. Update apt"
apt-get update -qq &> /dev/null || exit 1

echo "  2/7. Install python2 for ubuntu 16"
apt-get install python libldap2-dev python-dev libsasl2-dev libssl-dev python-pip cowsay -y

echo "  3/7. Add Ansible PPA"
apt-add-repository ppa:ansible/ansible &> /dev/null || exit 1

echo "  4/7. Update apt to grab new PPA info for Ansible"
apt-get update -qq &> /dev/null || exit 1

echo "  5/7. Install Ansible"
apt-get install -qq ansible

echo "  6/7. Remove auto-installed packages that are no longer required"
apt-get -y autoremove &> /dev/null || exit 1

echo "  6/7. Installing pip pacakages"
pip install python-ldap

echo "Ansible Provisioning:"

cd /vagrant/

echo "  2/2. Ansible (allthethings)..."
ansible-galaxy install -r roles/requirements.yml -p roles
ansible-playbook vagrant.yml -i "localhost," --connection=local --extra-vars "PROJECT_APP_PATH=/vagrant"

echo "Ansible Provisioning: Done!"
