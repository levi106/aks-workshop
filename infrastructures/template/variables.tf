variable "subscription_id" {
    type            = string
    description     = "Subscription ID"
}

variable "resource_group_name" {
    type            = string
    description     = "Name of the resource group."
}

variable "agent_count" {
    default = 3
}

variable "vm_size" {
    default = "Standard_B2ms"
}

variable "location" {
    default  = "japaneast"
}

variable "cluster_name" {
    default = "k8stest"
}

variable "dns_prefix" {
    default = "k8stest"
}

variable "log_analytics_workspace_name" {
    default = "k8stest-la"
}

variable "log_analytics_workspace_sku" {
    default = "PerGB2018"
}