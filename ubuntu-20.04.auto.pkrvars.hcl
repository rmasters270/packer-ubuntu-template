iso                  = "https://releases.ubuntu.com/20.04.4/ubuntu-20.04.4-live-server-amd64.iso"
iso_checksum         = "sha256:28ccdb56450e643bad03bb7bcf7507ce3d8d90e8bf09e38f6bd9ac298a98eaad"
iso_storage_pool     = "nas"

vmid                 = 9204
template_name        = "ubuntu-2004"
template_description = "packer generated on {{isotime `2006-01-02`}}"
os                   = "l26"
memory               = 2048
cores                = 1
sockets              = 1
disk_size            = "10GB"
disk_pool            = "zfs"
disk_pool_type       = "zfspool"
enable_cloud_init    = true
