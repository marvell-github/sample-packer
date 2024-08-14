# Define the build block
build {
  # Define the Docker builder
  source "docker" {
    # Base Docker image to use
    image = "ubuntu:20.04"
    # Whether to commit the changes to a new image
    commit = true
    # List of Dockerfile-like commands to modify the base image
    change {
      type    = "run"
      command = "apt-get update -y"
    }
    change {
      type    = "run"
      command = "apt-get install -y curl"
    }
  }

  # Define provisioners to configure the image
  provisioner "shell" {
    inline = [
      "echo 'Hello, Packer!' > /hello.txt",
      "curl -sSL https://get.docker.com | sh"
    ]
  }

  # Post-processors to tag the Docker image
  post-processor "docker-tag" {
    repository = "my-repo/my-image"
    tag        = "latest"
  }
}
