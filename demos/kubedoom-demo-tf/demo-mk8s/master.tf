# Master
resource "yandex_kubernetes_cluster" "zonal_cluster" {
  name        = "demo-kubedoom"
  description = "Demonstration of chaos engineering with kubedoom"

  network_id = yandex_vpc_network.this.id
  network_implementation {
    cilium {}
  }

  master {
    version = "1.23"
    public_ip = true
    zonal {
      zone      = var.my_zone
      subnet_id = yandex_vpc_subnet.this.id
    }
    security_group_ids = [yandex_vpc_security_group.sg_k8s.id, yandex_vpc_security_group.k8s_master_whitelist.id, ]

    maintenance_policy {
      auto_upgrade = true

      maintenance_window {
        start_time = "22:00"
        duration   = "8h"
      }
    }
  }
  service_ipv4_range = var.k8s_service_ipv4_range
  cluster_ipv4_range = var.k8s_pod_ipv4_range
  release_channel    = "RAPID"
  service_account_id      = yandex_iam_service_account.k8s_master_sa.id
  node_service_account_id = yandex_iam_service_account.k8s_node_sa.id

  labels = var.labels
  depends_on = [yandex_vpc_subnet.this,
    yandex_resourcemanager_folder_iam_member.service_account_master,
    yandex_resourcemanager_folder_iam_member.service_account_node,
    null_resource.iam_sleep]
}
