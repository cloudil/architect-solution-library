### VPC
resource "yandex_vpc_network" "this" {
  name        = var.network_name
  description = var.network_description

  labels = var.labels
}
resource "yandex_vpc_subnet" "this" {
  name           = "kubedoom-subnet"
  description    = "subnet for k8s kubedoom demo"
  v4_cidr_blocks = [var.subnet_cidr]
  zone           = var.my_zone
  network_id     = yandex_vpc_network.this.id
  labels         = var.labels

  depends_on = [
    yandex_vpc_network.this
  ]
}