terraform {
  required_providers {
    linode = {
      source  = "linode/linode"
      version = "2.4.0"
    }
    doppler = {
      source = "DopplerHQ/doppler"
    }
  }
}

data "linode_profile" "me" {}

# Configure the Doppler provider with the token
provider "doppler" {
  doppler_token = var.doppler_token
}

# Define our data source to fetch secrets
data "doppler_secrets" "this" {}

provider "linode" {
  token = data.doppler_secrets.this.map.LINODE_TOKEN
}

resource "linode_instance" "inworld-discord" {
    label = "inworld-discord"
    image = "linode/ubuntu22.04"
    region = "us-southeast"
    type = "g6-standard-1"
    authorized_keys = [data.doppler_secrets.this.map.AUTH_KEY]
    authorized_users = [data.linode_profile.me.username]
    root_pass = data.doppler_secrets.this.map.ROOT_PASS

    tags = var.tags
    private_ip = true
}