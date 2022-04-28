packer {
  required_plugins {
    proxmox = {
      version = " >= 1.0.1"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}

source "proxmox-iso" "ubuntu" {

  proxmox_url = "https://${var.proxmox_host}/api2/json"
  node        = var.proxmox_node
  username    = var.proxmox_user
  password    = var.proxmox_password
  token       = var.proxmox_token

  iso_url          = var.iso
  iso_checksum     = var.iso_checksum
  iso_storage_pool = var.iso_storage_pool
  unmount_iso      = true

  vm_id                   = var.vmid
  vm_name                 = var.template_name
  template_description    = var.template_description
  os                      = var.os
  memory                  = var.memory
  cores                   = var.cores
  sockets                 = var.sockets
  qemu_agent              = true
  cloud_init              = var.enable_cloud_init
  cloud_init_storage_pool = var.disk_pool
  disks {
    type              = "scsi"
    disk_size         = var.disk_size
    storage_pool      = var.disk_pool
    storage_pool_type = var.disk_pool_type
    format            = "raw"
  }
  network_adapters {
    model  = "virtio"
    bridge = "vmbr0"
  }

  ssh_username = var.ssh_user
  ssh_password = var.ssh_password
  ssh_timeout  = "30m"

  http_directory           = "${path.root}/http"
  insecure_skip_tls_verify = true

  boot_wait    = "6s"
  boot_command = var.boot_command
}

build {
  sources = ["source.proxmox-iso.ubuntu"]

  provisioner "ansible" {
    playbook_file = "${path.root}/ansible/cleanup.yml"
    inventory_directory = pathexpand("~/.ansible/inventory")
    ansible_env_vars = [
        "ANSIBLE_REMOTE_TMP=/tmp/ansible",
    ]
    extra_arguments = [
      "--vault-password-file=~/.vault-key",
      "--extra-vars",
      "ansible_become_pass=${var.ssh_password}",
    ]
  }
}
