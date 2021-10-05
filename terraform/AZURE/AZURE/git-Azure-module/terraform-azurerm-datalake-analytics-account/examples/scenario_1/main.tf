
locals {
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

data "azurerm_data_lake_store" "lake_store" {
  name                = var.user_parameters.naming_service.data_lake.dl01
  resource_group_name = data.azurerm_resource_group.app_env_resource_group.name
}

module "datalake-analytics-account" {
  source                           = "../../"
  resource_group_name              = data.azurerm_resource_group.app_env_resource_group.name
  location                         = "East US 2"
  data_lake_analytics_account_name = "dlanalaccountna"
  default_store_account_name       = data.azurerm_data_lake_store.lake_store.name
  tier                             = "Consumption"
  tags                             = local.tags
}
