# Define required plugins
packer {
  required_plugins {
    docker = {
      source  = "github.com/hashicorp/docker"
      version = ">= 1.0.0"
    }
  }
}

# Define the source for Docker
source "docker" "ubuntu" {
  image = "ubuntu:20.04"
}

# Define the build steps
build {
  sources = ["source.docker.ubuntu"]

  provisioner "shell" {
    inline = [
      "apt-get update",
      "apt-get install -y nginx",
      "echo 'Hello, World!' > /var/www/html/index.html"
    ]
  }

  post-processor "docker-tag" {
    repository = "my-docker-image"
    tag        = "v1.0.0"
  }
}
