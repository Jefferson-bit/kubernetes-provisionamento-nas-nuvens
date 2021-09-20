terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.14.0"
    }
  }
}

provider "docker" {
  version = "~> 2.7"
  host    = "npipe:////.//pipe//docker_engine"
}
resource "docker_image" "docusaurus-zup" {
  name = "public.ecr.aws/zup-academy/docusaurus-zup:latest"
}