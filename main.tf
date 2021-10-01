terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.15.0"
    }
  }
}

provider "docker" {
  host = "npipe:////.//pipe//docker_engine"
}

variable "container_count" {
  type        = number
  default     = 1
}

variable "external_port" {
  type        = number
  default     = 3000
}

variable "internal_port" {
  type        = number
  default     = 3000
}

resource "random_string" "random" {
  count = var.container_count
  length  = 6
  special = false
  upper   = false
}

resource "docker_image" "docusaurus-zup" {
  name = "public.ecr.aws/zup-academy/docusaurus-zup:latest"
}

resource "docker_container" "docusaurus-zup" {
  count = var.container_count
  name  = join( "-", ["docusaurus-zup", random_string.random[count.index].result])
  image = docker_image.docusaurus-zup.latest
  ports {
    internal = var.internal_port
    external = var.external_port
  }
}

output "container_name" {
  value = docker_container.docusaurus-zup[*].name
}

output "ip_address" {
  value = [for i in docker_container.docusaurus-zup[*]: join(":", [i.ip_address],i.ports[*]["external"])]
}
