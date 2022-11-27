# Packer Proxmox Ubuntu Template

Use Packer to create a Proxmox Template of Ubuntu server using Subiquity with an option for a Cloud Init drive.

## Build Image Template

`packer build .`

## Customize

- Create a new file, `secrets.auto.pkrvars.hcl` and populate variables for your environment.
- Use `mkpasswd` to generate a hashed ssh_password.  Populate the hashed password in `.ubuntu\http\user-data`.
- Change any values in `ubuntu-20.04.auto.pkrvars.hcl` to suite your environment.
- Define Ansible inventory variables.

```ini
secrets.auto.pkrvars.hcl

proxmox_host    = "pve.example.com:8006"
proxmox_node    = "pve-01"
proxmox_user    = "root@pam!token"
proxmox_token   = "AAAAAAAA-BBBB-2222-1111-DDDDDDDDDDDD"
ssh_user        = "ubuntu"
ssh_password    = "password"
```

### Variables

| variable             | default   | required | description                                       |
|----------------------|-----------|----------|---------------------------------------------------|
| proxmox_host         |           | Yes      | Proxmox FQDN host name and port                   |
| proxmox_node         |           | Yes      | Proxmox node name                                 |
| proxmox_user         |           | Yes      | Proxmox user name                                 |
| proxmox_password     | ""        | No       | Proxmox password                                  |
| proxmox_token        | ""        | No       | Proxmox api token                                 |
| iso                  |           | Yes      | URL to an ISO which will upload to Proxmox        |
| iso_checksum         |           | Yes      | Checksum of the ISO                               |
| iso_storage_pool     | local     | No       | Proxmox storage pool to upload the ISO            |
| vmid                 | null      | No       | Proxmox virtual machine ID                        |
| template_name        | ubuntu    | No       | Name of template in Proxmox                       |
| template_description | null      | No       | Proxmox notes field                               |
| os                   | l26       | No       | Operating system type                             |
| memory               | 1024      | No       | Memory in MB                                      |
| cores                | 1         | No       | Number of CPU cores                               |
| sockets              | 1         | No       | Number of CPU sockets                             |
| disk_size            | 20GB      | No       | The size of the disk including a unit suffix      |
| disk_pool            | local-lvm | No       | Name of Proxmox storage pool                      |
| disk_pool_type       | lvm-thin  | No       | Type of the pool                                  |
| enable_cloud_init    | False     | No       | Add Cloud init drive to disk_pool location        |
| ssh_user             | ubuntu    | No       | SSH user                                          |
| ssh_password         |           | Yes      | SSH password                                      |
| boot_wait            | 6s        | No       | Seconds to wait before entering the boot command. |
| boot_command         |           | Yes      | Boot command to auto install Ubuntu               |

#### Additional Variable Information

`proxmox_user`: Proxmox user account must be in the format `user`@`domain`!`token_name`.  If a Proxmox password is used omit the `token_name`.

`proxmox_password`: Either the password or the token must be provided.  The token is preferred.  If both are given the token will take precedence. If a password is given the token name may be omitted from the `proxmox_user`.

`proxmox_token`: Either the token or the password must be provided.  The token is preferred.  If both are given the token will take precedence. If a token is given the token name must be included in the `proxmox_user`.

`ssh_password`: Use `mkpasswd -m sha-512 -s` to generate a hashed password for the ssh_user account.  Put this hashed password in the ubuntu\http\user-data file.  This should match the plain text packer variable.

`boot_wait`: Depending on your hardware you may need to adjust the boot wait time.  Too short or too long and the automated boot sequence will not execute.

## Other Configuration

### Ansible Provisioner

The Packer build uses the Ansible Provisioner to accomplish the following tasks:

- Update and clean up installed apt packages.
- Remove the machine-id.
- Update netplan for use with Cloud Init.
- Prepare and Cloud Init.

Ansible Inventory is assumed to be located in `~/.ansible/inventory`.  Ansible vault encrypted files in the inventory assume the key is located in `~/.vault-key`. Both paths are defined in `ubuntu.pkr.hcl` if the values need to be modified.

### Cloud Init

The template, `99_pve.cfg.j2`, defines Cloud Init configuration. The file accomplishes the following:

- Set time zone.
- Allow cloud init to define the default user.
- Upgrade installed packages.
- Grow the partition to fit the disk size assigned in Cloud Init.
- Apply netplan.
- Create a birth certificate when child machines are created.
