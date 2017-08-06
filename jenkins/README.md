Jenkins installation
====================

Using ansible we will provison our Jenkins instance to test and deploy
python apps in Azure. It will install and configure jenkins to test
python applications (see [python-jenkins-template][python_jenkins_template] for more
info)

Requirements
------------

 * [Ansible][ansible]
 * Public IP from instance in Azure (see _../infrastructure_ folder)
 * Github ssh key pair

To install _java_ and _jenkins_ playbooks, run:

 * `ansible-galaxy install -r requirements.yml -p roles`

Provision
---------

To provision a remote instance, just follow these steps:

 1. Create and fill _inventory_ from _.dist_ file.
 2. Create and fill in *secret_vars/jenkins* from _.dist_ file.
 2. Run ansible `ansible-playbook -i inventory remote.yml` to provision
    server

Test
----

TBD

Author
------

Juan Carlos Castillo Cano

[ansible]:https://www.ansible.com/
[python_jenkins_template]:https://github.com/bobuss/python-jenkins-template
