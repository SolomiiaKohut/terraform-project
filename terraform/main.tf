resource "digitalocean_vpc" "vpc" {
  name     = "${var.name}-vpc"
  region   = var.region
  ip_range = "10.10.10.0/24"
}

resource "digitalocean_droplet" "vm" {
  name   = "${var.name}-node"
  region = var.region
  size   = "s-2vcpu-4gb"
  image  = "ubuntu-24-04-x64"

  vpc_uuid = digitalocean_vpc.vpc.id

  ssh_keys = [var.ssh_key_id]
}

resource "digitalocean_firewall" "fw" {
  name = "${var.name}-firewall"

  droplet_ids = [digitalocean_droplet.vm.id]

  inbound_rule {
    protocol = "tcp"
    port_range = "22"
    source_addresses = ["0.0.0.0/0"]
  }

  inbound_rule {
    protocol = "tcp"
    port_range = "80"
    source_addresses = ["0.0.0.0/0"]
  }

  inbound_rule {
    protocol = "tcp"
    port_range = "443"
    source_addresses = ["0.0.0.0/0"]
  }

  inbound_rule {
    protocol = "tcp"
    port_range = "8000-8003"
    source_addresses = ["0.0.0.0/0"]
  }

  outbound_rule {
    protocol = "tcp"
    port_range = "1-65535"
    destination_addresses = ["0.0.0.0/0"]
  }
}


resource "digitalocean_spaces_bucket" "bucket" {
  name   = "${var.name}-bucket"
  region = var.region
}
