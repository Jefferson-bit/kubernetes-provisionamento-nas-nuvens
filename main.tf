module "image" {
  for_each     = local.image_type
  source       = "./image"
  image_stored = each.value.image

}

module "container" {
  for_each        = local.image_type
  source          = "./container"
  count_stored    = each.value.container_count
  name_stored     = each.key
  image_stored    = module.image[each.key].image_module
  internal_stored = each.value.internal
  external_stored = each.value.external

}

