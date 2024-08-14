# Define the build block
source "docker" "my_docker_image" {
  # Base Docker image to use
  image = "ubuntu:20.04"
  # Whether to commit the changes to a new image
  commit = true
}

# Define the build block
build {
  # Use the defined Docker source
  sources = ["source.docker.my_docker_image"]

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
