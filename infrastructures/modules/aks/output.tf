output "aks_ssh_public_key" {
    value = tls_private_key.example_ssh_private_key.public_key_openssh
}
output "aks_ssh_private_key" {
    value = tls_private_key.example_ssh_private_key.private_key_pem
}
output "kube_config" {
    value = azurerm_kubernetes_cluster.k8s.kube_config_raw
}