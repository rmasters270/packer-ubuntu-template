variable "proxmox_host" {
  type        = string
  description = "Proxmox FQDN host name and port"
}
variable "proxmox_node" {
  type        = string
  description = "Proxmox node name"
}
variable "proxmox_user" {
  type        = string
  description = "Proxmox user name"
}
variable "proxmox_password" {
  type        = string
  description = "Proxmox password"
  default = ""
  sensitive   = true
}
variable "proxmox_token" {
  type        = string
  description = "Proxmox api token"
  default = ""
  sensitive   = true
}

variable "iso" {
  type        = string
  description = "URL to an ISO which will upload to Proxmox"
}
variable "iso_checksum" {
  type        = string
  description = "Checksum of the ISO"
}
variable "iso_storage_pool" {
  type        = string
  description = "Proxmox storage pool to upload the ISO"
  default     = "local"
}

variable "vmid" {
  type        = number
  description = "Proxmox virtual machine ID"
  default     = null
}
variable "template_name" {
  type        = string
  description = "Name of template in Proxmox"
  default     = "ubuntu"
}
variable "template_description" {
  type        = string
  description = "Proxmox notes field"
  default     = null
}
variable "os" {
  type        = string
  description = "Operating system type"
  default     = "l26"
}
variable "memory" {
  type        = number
  description = "Memory in MB"
  default     = 1024
}
variable "cores" {
  type        = number
  description = "Number of CPU cores"
  default     = 1
}
variable "sockets" {
  type        = number
  description = "Number of CPU sockets"
  default     = 1
}
variable "disk_size" {
  type        = string
  description = "The size of the disk including a unit suffix"
  default     = "20GB"
}
variable "disk_pool" {
  type        = string
  description = "Name of Proxmox storage pool"
  default     = "local-lvm"
}
variable "disk_pool_type" {
  type        = string
  description = "Type of the pool"
  default     = "lvm-thin"
}
variable "enable_cloud_init" {
  type        = bool
  description = "Add Cloud init drive to disk_pool location"
  default     = false
}

variable "ssh_user" {
  type        = string
  description = "SSH user"
  default     = "ubuntu"
}
variable "ssh_password" {
  type        = string
  description = "SSH password"
  sensitive = true
}

variable "boot_wait" {
  type = string
  description = "Seconds to wait before entering the boot command."
  default = "6s"
}
variable "boot_command" {
  type        = list(string)
  description = "Boot command to auto install Ubuntu"
}
