packer {
  required_plugins {
    docker = {
      source  = "github.com/hashicorp/docker"
      version = "~> 1.0"
    }
  }
}

# Define the Docker source
source "docker" "my_docker_image" {
  image  = "ubuntu:20.04"
  commit = true
}

# Define the build block
build {
  sources = ["source.docker.my_docker_image"]

  provisioner "shell" {
    inline = [
      "echo 'Hello, Packer!' > /hello.txt",
      "curl -sSL https://get.docker.com | sh"
    ]
  }

  post-processor "docker-tag" {
    repository = "my-repo/my-image"
    tag        = ["latest"]  # Corrected to a list of strings
  }
}
