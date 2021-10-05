locals {
  vnet_resource_group_name = replace(var.system_parameters.VNET, "-VNT-", "-RGP-BASE-")
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

module "storage_account" {
  source                     = "../../"
  name                       = var.user_parameters.naming_service.storage.k01
  resource_group_name        = data.azurerm_resource_group.app_env_resource_group.name
  account_tier               = "Premium" # Possible values: Standard, Premium
  account_replication_type   = "LRS"      # Possible values: LRS, GRS, RAGRS, ZRS
  account_kind               = "StorageV2"
  location                   = data.azurerm_resource_group.app_env_resource_group.location
  default_action             = "Allow"
  ip_rules                   = []
  virtual_network_subnet_ids = []
  access_tier                = "Hot"
  bypass                     = []
  tags                       = local.tags
}

