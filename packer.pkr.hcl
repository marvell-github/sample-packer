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
      "apt-get update -y",
      "apt-get install -y apt-utils curl",
      "echo 'Hello, Packer!' > /hello.txt",
      "curl -sSL https://get.docker.com | sh"
    ]
  }

  post-processor "docker-tag" {
    repository = "my-repo/my-docker-image"
    tag        = ["latest"]
  }
}
