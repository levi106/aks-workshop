variable "resource_group_name" {
    type            = string
}

variable "location" {
    type = string
}

variable "agent_count" {
}

variable "vm_size" {
    type = string
}

variable "cluster_name" {
    type = string
}

variable "dns_prefix" {
    type = string
}

variable "log_analytics_workspace_name" {
    type = string
}

variable "log_analytics_workspace_sku" {
    type = string
}