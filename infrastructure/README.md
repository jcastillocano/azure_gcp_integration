Terraform scripts to provision infrastructure
=============================================

This repo contains all the terraform templates to provison both Azure
and Google clouds with some basic infrastructure + CI/CD pipeline in
Jenkins.

Ideally all the deployment environment should be configure with
terraform, but since there is not _appservice_ resource yet for Azure
(see [Create azure App Service Plan resource][terraform_issues])
everything (from provision to deployments) will be manage by Azure
_cli_.

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

To test any pending change, use _plan_. In example:

```
$ terraform plan -var-file=azure.tfvars
......
+ azurerm_resource_group.web
    location: "westeurope"
    name:     "web"
    tags.%:   "<computed>"


Plan: 1 to add, 0 to change, 0 to destroy.
```

Execute
-------

To apply changes to current environment, use _apply_. In example:

```
$ terraform apply -var-file=azure.tfvars
azurerm_resource_group.web: Creating...
  location: "" => "westeurope"
  name:     "" => "web"
  tags.%:   "" => "<computed>"
azurerm_resource_group.web: Creation complete (ID: /subscriptions/0a7c7d3a-dd97-4a38-abfd-f8946165893b/resourceGroups/web)

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

In order to create App Service for our test app we will need to run
these Azure CLI commands:

 1. Create App Service `az appservice plan create --name testAppPlan --resource-group default --sku FREE`
 2. Create Web App `az webapp create --name python-app-test --resource-group default --plan testAppPlan`. Note *defaultHostName*
 3. Configure Web App for Python 2.7 `az webapp config set --python-version 2.7 --name python-app-test --resource-group default`
 4. Create deploy user `az webapp deployment user set --user-name deployertestapp --password _secret password_`
 5. Configure local git deployment `az webapp deployment source
    config-local-git --name python-app-test --resource-group default
--query url --output tsv`. Note github repo.`

Author
------

Juan Carlos Castillo Cano - jccastillocano@gmail.com

[azure_cli]:https://docs.microsoft.com/en-us/cli/azure/install-azure-cli
[azure_credentials]:https://www.terraform.io/docs/providers/azurerm/index.html#creating-credentials
[terraform_issues]:https://github.com/terraform-providers/terraform-provider-azurerm/pull/1
