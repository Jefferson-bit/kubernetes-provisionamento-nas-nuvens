resource "random_string" "random" {
  count   = var.container_count
  length  = 6
  special = false
  upper   = false
}

resource "docker_image" "docusaurus-zup" {
  name = "public.ecr.aws/zup-academy/docusaurus-zup:latest"
}

resource "docker_container" "docusaurus-zup" {
  count = var.container_count
  name  = join("-", ["docusaurus-zup", random_string.random[count.index].result])
  image = docker_image.docusaurus-zup.latest
  ports {
    internal = var.internal_port
    external = var.external_port
  }
}