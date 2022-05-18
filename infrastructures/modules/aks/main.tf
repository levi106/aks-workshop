resource "random_id" "log_analytics_workspace_name_suffix" {
    byte_length = 8
}

resource "azurerm_log_analytics_workspace" "la" {
    name                = "${var.log_analytics_workspace_name}-${random_id.log_analytics_workspace_name_suffix.dec}"
    location            = var.location
    resource_group_name = var.resource_group_name
    sku                 = var.log_analytics_workspace_sku
}

resource "azurerm_log_analytics_solution" "ci" {
    solution_name           = "ContainerInsights"
    location                = var.location
    resource_group_name     = var.resource_group_name
    workspace_resource_id   = azurerm_log_analytics_workspace.la.id
    workspace_name          = azurerm_log_analytics_workspace.la.name

    plan {
        publisher = "Microsoft"
        product = "OMSGallery/ContainerInsights"
    }
}

resource "tls_private_key" "example_ssh_private_key" {
    algorithm   = "RSA"
    rsa_bits    = 4096
}

resource "azurerm_kubernetes_cluster" "k8s" {
    name                = var.cluster_name
    location            = var.location
    resource_group_name = var.resource_group_name
    dns_prefix          = var.dns_prefix

    linux_profile {
        admin_username = "azureuser"

        ssh_key {
            key_data = tls_private_key.example_ssh_private_key.public_key_openssh
        }
    }

    default_node_pool {
        name              = "agentpool"
        node_count        = var.agent_count
        vm_size           = var.vm_size
    }

    identity {
        type = "SystemAssigned"
    }

    network_profile {
        load_balancer_sku   = "standard"
        network_plugin      = "kubenet"
    }

    oms_agent {
        log_analytics_workspace_id  = azurerm_log_analytics_workspace.la.id
    }
}