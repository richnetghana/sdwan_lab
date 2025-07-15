provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_droplet" "sdwan" {
  name   = "sdwan-node"
  region = "nyc3"
  size   = "s-1vcpu-1gb"
  image  = "docker-20-04"
  ssh_keys = [var.ssh_fingerprint]

  connection {
    user = "root"
    type = "ssh"
    private_key = file(var.private_key_path)
  }

  provisioner "remote-exec" {
    inline = [
      "apt update && apt install -y docker-compose git",
      "git clone https://github.com/richnetghana/Systems-Network.git",
      "cd Systems-Network/sdwan-lab && docker-compose up -d"
    ]
  }
}

variable "do_token" {}
variable "ssh_fingerprint" {}
variable "private_key_path" {}
