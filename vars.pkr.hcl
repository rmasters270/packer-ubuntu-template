variable "proxmox_host" {
  type        = string
  description = "Proxmox host name and port"
  default     = "pve-fqdn:8006"
}
variable "proxmox_node" {
  type        = string
  description = "Proxmox node name"
  default     = "pve"
}
variable "proxmox_user" {
  type        = string
  description = "Proxmox user name"
  default     = "root@pam!token"
}
variable "proxmox_password" {
  type        = string
  description = "Proxmox user password"
  sensitive   = true
  default     = "password"
}
variable "proxmox_token" {
  type        = string
  description = "Proxmox api token"
  sensitive   = true
}

variable "iso" {
  type        = string
  description = "URL to an ISO to upload to Proxmox"
  default     = "https://releases.ubuntu.com/20.04.4/ubuntu-20.04.4-live-server-amd64.iso"
}
variable "iso_checksum" {
  type        = string
  description = "Checksum of the ISO"
  default     = "sha256:28ccdb56450e643bad03bb7bcf7507ce3d8d90e8bf09e38f6bd9ac298a98eaad"
}
variable "iso_storage_pool" {
  type        = string
  description = "Proxmox storage pool to upload the ISO"
  default     = "local"
}

variable "vmid" {
  type        = number
  description = "Virtual machine ID"
  default     = 100
}
variable "template_name" {
  type        = string
  description = "Name of template in Proxmox"
  default     = "ubuntu"
}
variable "template_description" {
  type        = string
  description = "Proxmox user token"
  default     = "packer generated"
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
