terraform {
  required_providers {
    vsphere = {
      source = "hashicorp/vsphere"
      version = "2.11.1"
    }
  }
}

provider "vsphere" {
  user                 = var.vsphere_user
  password             = var.vsphere_password
  vsphere_server       = var.vsphere_server
  allow_unverified_ssl = var.vsphere_allow_unverified_ssl
  api_timeout          = var.vsphere_api_timeout
}

data "vsphere_datacenter" "datacenter" {
  name = var.vsphere_datacenter_name
}

data "vsphere_datastore" "datastore" {
  name          = "${var.vsphere_environment_id}-storage"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.vsphere_compute_cluster_name
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_network" "network" {
  name          = "${var.vsphere_environment_id}-segment"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

locals {
  vsphere_folder = "${var.vsphere_compute_cluster_name}/${var.vsphere_environment_id}"
}

resource "vsphere_virtual_machine" "vm" {
  count                      = var.vsphere_vm_count
  name                       = "${var.vsphere_vm_name_prefix}-${count.index + 1}"
  resource_pool_id           = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id               = data.vsphere_datastore.datastore.id
  num_cpus                   = var.vsphere_vm_cpus
  memory                     = var.vsphere_vm_memory
  guest_id                   = var.vsphere_vm_guest_os_id
  folder                     = local.vsphere_folder
  firmware                   = var.vsphere_vm_firmware
  wait_for_guest_ip_timeout  = var.vsphere_vm_wait_for_guest_ip_timeout
  wait_for_guest_net_timeout = var.vsphere_vm_wait_for_guest_net_timeout

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = var.vsphere_vm_nic_adapter_type
  }
  disk {
    label = "${var.vsphere_vm_name_prefix}-${count.index + 1}-hard-disk"
    size  = var.vsphere_vm_disk_size
  }
}