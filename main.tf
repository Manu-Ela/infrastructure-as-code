# Configure the Docker provider
provider "docker" {
  host = "unix:///var/run/docker.sock"
}

resource "docker_image" "nginx"{
  name = "nginx"
}


resource "docker_container" "webapp"{
  image = docker_image.nginx.latest
  name = "nginx-terraform"
  volumes {
    host_path = "${abspath(path.root)}/app"
    container_path = "/usr/share/nginx/html"
    read_only = true
  }
  ports{
    internal = "80"
    external = "10004"
    protocol = "tcp"
    ip = "0.0.0.0"
  }
}
