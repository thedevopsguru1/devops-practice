locals {
  vnet_resource_group_name = replace(var.system_parameters.VNET, "N-VNT", "N-RGP-BASE")
  tags = {
    "ghs-los" : var.system_parameters.TAGS.ghs-los,
    "ghs-solution" : var.system_parameters.TAGS.ghs-solution,
    "ghs-appid" : var.system_parameters.TAGS.ghs-appid,
    "ghs-solutionexposure" : var.system_parameters.TAGS.ghs-solutionexposure,
    "ghs-serviceoffering" : var.system_parameters.TAGS.ghs-serviceoffering,
    "ghs-environment" : var.system_parameters.TAGS.ghs-environment,
    "ghs-owner" : var.system_parameters.TAGS.ghs-owner,
    "ghs-apptioid" : var.system_parameters.TAGS.ghs-apptioid,
    "ghs-envid" : var.system_parameters.TAGS.ghs-envid,
    "ghs-tariff" : var.system_parameters.TAGS.ghs-tariff,
    "ghs-srid" : var.system_parameters.TAGS.ghs-srid,
    "ghs-environmenttype" : var.system_parameters.TAGS.ghs-environmenttype,
    "ghs-deployedby" : var.system_parameters.TAGS.ghs-deployedby,
    "ghs-dataclassification" : var.system_parameters.TAGS.ghs-dataclassification
  }
}

data "azurerm_resource_group" "app_env_resource_group" {
  name = var.__ghs.environment_resource_groups
}

data "azurerm_monitor_action_group" "action_group" {
  resource_group_name = data.azurerm_resource_group.app_env_resource_group.name
  name                = "APP-INSIGHTS-ACTION-GRP"
}

module "monitor-activity-log-alert" {
  source                    = "../../"
  name                      = "monitor-activity-log-alert-name"
  resource_group_name       = data.azurerm_resource_group.app_env_resource_group.name
  monitor_action_group_name = data.azurerm_monitor_action_group.action_group.name
  description               = "monitor-activity-log-alert-description"  
  scopes                    = [data.azurerm_resource_group.app_env_resource_group.id]
  resource_id               = "/subscriptions/4942ac67-943a-4f66-95ca-0068c4455040/resourceGroups/PZI-GXUS-G-RGP-OOFMH-T007/providers/Microsoft.Compute/virtualMachines/testlinuxavzone"
  operation_name            = "Microsoft.Storage/storageAccounts/write"
  category                  = "Recommendation"
  level                     = "Informational"
  status                    = ""
  tags = local.tags
}
