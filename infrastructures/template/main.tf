resource "azurerm_resource_group" "rg" {
    name        = var.resource_group_name
    location    = var.location
}

module "aks" {
    source                          = "../modules/aks"

    resource_group_name             = azurerm_resource_group.rg.name
    location                        = var.location
    cluster_name                    = var.cluster_name
    agent_count                     = var.agent_count
    vm_size                         = var.vm_size
    dns_prefix                      = var.dns_prefix
    log_analytics_workspace_name    = var.log_analytics_workspace_name
    log_analytics_workspace_sku     = var.log_analytics_workspace_sku
}
