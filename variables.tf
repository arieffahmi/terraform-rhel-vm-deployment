variable "vsphere_user" {
  type        = string
  description = "The username for the vSphere user"
  sensitive   = true
}

variable "vsphere_password" {
  type        = string
  description = "The password for the vSphere user"
  sensitive   = true
}

variable "vsphere_server" {
  type        = string
  description = "The URL of the vSphere server"
  sensitive   = true
}

variable "vsphere_allow_unverified_ssl" {
  type        = bool
  default     = true
  description = "Whether to allow unverified SSL connections to the vSphere server"
  sensitive    = false
}

variable "vsphere_api_timeout" {
  type        = number
  default     = 10
  description = "The API timeout for vSphere connections in seconds"
  sensitive    = false
}

variable "vsphere_datacenter_name" {
  type = string
  default = "IBMCloud"
}

variable "vsphere_environment_id" {
  type = string
  default = "68db4b7d828e3846d3cd6291"
}

variable "vsphere_compute_cluster_name" {
  type = string
  default = "ocp-gym"
}

variable "vsphere_vm_count" {
  type = number
  default = 2
}

variable "vsphere_vm_name_prefix" {
  type = string
  default = "terraform-lab-vm"
}

variable "vsphere_vm_cpus" {
  type = number
  default = 2
}

variable "vsphere_vm_memory" {
  type = number
  default = 2048
}

variable "vsphere_vm_firmware" {
  type = string
  default = "efi"
}

variable "vsphere_vm_nic_adapter_type" {
  type = string
  default = "vmxnet3"
}

variable "vsphere_vm_disk_size" {
  type = number
  default = 20
}

variable "vsphere_vm_guest_os_id" {
  type = string
  default = "rhel9_64Guest"
}

variable "vsphere_vm_wait_for_guest_ip_timeout" {
  type = number
  default = 0
}

variable "vsphere_vm_wait_for_guest_net_timeout" {
  type = number
  default = 0
}