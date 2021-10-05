locals {

  app_keys = flatten([
    for num in range(var.app_count) : [
      for key_prefix in local.key_prefixes :
      format("%sapp_%s", key_prefix, num + 1)
    ]
  ])

  app_values = flatten([
    for num in range(var.app_count) : [
      for format_option in local.common_resource_numbering_format :
      upper(format("%s-%s%s-%s-APP-%s-%s${format_option}", local.pwc_prefix_code, local.country_code_subscription, local.pwc_global_it_country_code_subscription, local.subscription_env_code, var.app_code, local.app_env_code, num + 1))
    ]
  ])

}

output "app_names" {
  value = zipmap(local.app_keys, local.app_values)
}