terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_droplet" "drop_test" {
  image              = var.droplet_image
  name               = "drop-test-v2"
  region             = var.droplet_region
  size               = var.droplet_size
  backups            = false
  monitoring         = false
    ssh_keys = [
    var.ssh_fingerprint
  ]
  user_data = templatefile("digitalocean.tftpl", {
    public_key = var.STAGING_PUBLIC_KEY
  })
}

output "droplet_ip" {
  value       = digitalocean_droplet.drop_test.ipv4_address
  description = "The public IPv4 address of the droplet"
}

variable "do_token" {
  description = "DigitalOcean API token"
  type        = string
  default     = ""
  sensitive   = true
}

variable "ssh_fingerprint" {
  description = "Fingerprint of your SSH key"
  type        = string
  default     = ""
  sensitive   = true
}

variable "droplet_image" {
  description = "Image identifier of the OS in DigitalOcean"
  type        = string
  default     = "ubuntu-24-04-x64"
}

variable "droplet_region" {
  description = "Droplet region identifier where the droplet will be created"
  type        = string
  default     = "nyc1"
}

variable "droplet_size" {
  description = "Droplet size identifier"
  type        = string
  default     = "s-1vcpu-1gb"
}

variable "STAGING_PUBLIC_KEY" {
  description = "Public SSH key for Ansible user, provided via env0 variable."
  type        = string
  sensitive   = true
}