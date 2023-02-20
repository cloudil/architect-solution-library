### K8s Node Groups

resource "yandex_kubernetes_node_group" "nodes" {
  name = "kubedome-nodegroup"
  cluster_id = yandex_kubernetes_cluster.zonal_cluster.id

  instance_template {
    platform_id = "standard-v3"
    metadata = {
      ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
    }
    network_interface {
      nat                = true
      subnet_ids         = [yandex_vpc_subnet.this.id]
      security_group_ids = [yandex_vpc_security_group.sg_k8s.id, yandex_vpc_security_group.k8s_public_services.id]
    }

    resources {
      memory = 4
      cores  = 2
    }

    boot_disk {
      type = "network-ssd"
      size = 64
    }

    scheduling_policy {
      preemptible = false
    }
  }

  scale_policy {
    auto_scale {
      min     = 1
      max     = 3
      initial = 1
    }
  }

  allocation_policy {
    location {
      zone = var.my_zone
    }
  }

  maintenance_policy {
    auto_upgrade = true
    auto_repair  = true
  }
  deploy_policy {
    max_expansion   = 2
    max_unavailable = 1
  }
  node_labels = {
    env = "demo"
  }
  node_taints = []
}