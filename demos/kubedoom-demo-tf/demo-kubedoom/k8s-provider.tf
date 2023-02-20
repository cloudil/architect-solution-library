
// Connect to managed kubernetes from terraform provider
//======================================================
data "yandex_client_config" "client" {
}

data "yandex_kubernetes_cluster" "kubernetes" {
  //name = yandex_kubernetes_cluster.zonal_cluster.name
  name = "demo-kubedoom"
}

provider "kubernetes" {
  //load_config_file = false
  host                   = data.yandex_kubernetes_cluster.kubernetes.master.0.external_v4_endpoint
  cluster_ca_certificate = data.yandex_kubernetes_cluster.kubernetes.master.0.cluster_ca_certificate
  token                  = data.yandex_client_config.client.iam_token
}