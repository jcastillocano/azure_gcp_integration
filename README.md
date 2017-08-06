Pipeline orchestrator
=====================

Welcome to Pipeline Orchestrator, an example of DevOps tools and
proccesses. This reposity delves into three different topics:

 * Insfrastructure as code: Terraform and Ansible.
 * Pipelines: from CI to CD (python app in Azure).
 * Good practices: tests, tests, tests!

Feel free to dig into each subfolder (code, infrastructure, jenkins)
where you will find more info. This is a brief summary of what you will
find.

Infrastructure
--------------

We are using terraform to initialize infrastructure in Azure and Google.
The idea behind terraform is we can test (plan), apply changes, revert,
destroy and much more just running command from the console. Every
change is tracked in github; state can be shared between developers if
we save it on any remote state provider.

Although I would've like to have 100% automated with terraform, there is one piece of
Azure infrastructure not supported yet: [App
Services][terraform_issues]. In order to achieve this 100% automation we
will use [Azure CLI][azure_cli] to complete this step.

Jenkins
-------

Provsion a Jenkins instance with everything you need for testing Python
applications (see [Python Template for Jenkins][python_jenkins_template]):

 * Pylint
 * Code coverage
 * Unit tests
 * Integration tests

It also creates a job to execute this pipeline for every push to
integration branch (develop):

 1. Merge from master
 2. Run tests
 3. Create release tag
 4. Merge to master
 5. Trigger deployment in Azure

Beside the fact we've achieved a CI/CD pipeline, this is far from being
a trully desirable pipeline. There are more step to fulfill, i.e.:

 * Blue/Green deployments: don't deploy straight away, create a green
   deployment where we can run some validations (integration tests, QA).
 * Environments: right now there is just one environment. More
   environments (ci, dev, qa, staging) are required.
 * Rollbacks: although there is roll back capability (checkout previous
   tag, push) it is not automated.

Code
----

This is a copy of the code we have in Azure repo
(https://python-app-test.scm.azurewebsites.net/python-app-test.git).
Using this repo we are able to deploy to Azure automatically just
pushing to master. Please have a look to README inside code to learn
more about quality standards, tests, etc.


Author
------

Juan Carlos Castillo Cano - <jccastillocano@gmail.com>



[terraform_issues]:https://github.com/terraform-providers/terraform-provider-azurerm/pull/1
[azure_cli]:https://docs.microsoft.com/cs-cz/cli/azure/install-azure-cli
[python_jenkins_template]:https://github.com/bobuss/python-jenkins-template
