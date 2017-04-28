#!/usr/bin/env bash

export PYTHONUNBUFFERED=1
export ANSIBLE_FORCE_COLOR=1
set -x
# Only run through the full install if Ansible hasn't been installed yet
if [ $(dpkg-query -W -f='${Status}' ansible 2>/dev/null | grep -c "ok installed") -eq 0 ];
then

  echo "Configuring the Server:"
  export DEBIAN_FRONTEND=noninteractive

  echo "  1/4. Add Ansible PPA"
  apt-add-repository ppa:ansible/ansible &> /dev/null || exit 1

  echo "  2/4. Update apt"
  apt-get update -qq &> /dev/null || exit 1

  echo "  3/4. Install python2 and ansible"
  apt-get -y -qq install python python-dev python-pip ansible || exit 1

  echo "  4/4. Remove auto-installed packages that are no longer required"
  apt-get -y autoremove &> /dev/null || exit 1

else
  echo "Server Configuration already completed, skipping to Ansible Playbook"
  echo "Making sure ansible is up to date. Update apt"
  apt-get update -qq &> /dev/null || exit 1
  apt-get install -qq ansible &> /dev/null || exit 1

fi

echo "Ansible Provisioning:"

cd /vagrant/

echo "  2/2. Ansible (allthethings)..."
ansible-galaxy install -r roles/requirements.yml -p roles
# Localhost can be replaced with any other ip address
ansible-playbook main.yml -i "localhost," --connection=local --extra-vars "PROJECT_APP_PATH=/vagrant"

echo "Ansible Provisioning: Done!"
