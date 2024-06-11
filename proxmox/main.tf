
terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
    }
  }
}

provider "proxmox" {
	pm_tls_insecure = true
	pm_api_url = "https://192.168.144.91:8006/api2/json"
	pm_user = var.proxmox_user
	pm_password = var.proxmox_password
	pm_otp = ""
}


variable "proxmox_user" {
  description = "Proxmox User"
  type        = string
  sensitive   = true
}

variable "proxmox_password" {
  description = "Proxmox Password"
  type        = string
  sensitive   = true
}

resource "proxmox_lxc" "basic" {
  target_node  = "proxmox"
  hostname     = "lxc-basic"
  ostemplate   = "local:vztmpl/debian-12-standard_12.2-1_amd64.tar.zst"
  password     = "BasicLXCContainer"
  unprivileged = true

  rootfs {
    storage = "local-lvm"
    size    = "8G"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "dhcp"
  }
}