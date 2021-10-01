resource "docker_container" "docusaurus-zup" {
  name  = var.name_stored
  image = var.image_stored

  ports {
    internal = var.internal_stored
    external = var.external_stored
  }
}