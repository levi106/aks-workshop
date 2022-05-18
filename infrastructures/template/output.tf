output "resource_group_name" {
    value = azurerm_resource_group.rg.name
}

output "kube_config" {
    value = module.aks.kube_config
    sensitive = true
}

output "aks_ssh_public_key" {
    value = module.aks.aks_ssh_public_key
    sensitive = true
}

output "aks_ssh_private_key" {
    value = module.aks.aks_ssh_private_key
    sensitive = true
}