Terraform scripts to provision infrastructure
=============================================

This repo contains all the terraform templates to provison both Azure
and Google clouds with some basic infrastructure + CI/CD pipeline in
Jenkins.

Requirements
------------

 * Terraform > 0.9.11
 * [Azure xPlat CLI tools][azure_cli]
 * [Azure credentials][azure_credentials]

Configure
---------

Copy _azure.tfvars.dist_ to _azure.tfvars_ and fill in all the
credentials variables. After this run `terraform init` to initialize
local terraform directory, followed by `terraform env new dev` to
create *dev* environment (NOTE: to switch environment, just run `terraform env
select <env>`).

Test
----

To test any pending change, use _plan_:

`terraform plan -var-file=azure.tfvars`

Execute
-------

To apply changes to current environment, use _apply_:

`terraform apply -var-file=azure.tfvars`

Author
------

Juan Carlos Castillo Cano - jccastillocano@gmail.com

[azure_cli]:https://docs.microsoft.com/en-us/cli/azure/install-azure-cli
[azure_credentials]:https://www.terraform.io/docs/providers/azurerm/index.html#creating-credentials
