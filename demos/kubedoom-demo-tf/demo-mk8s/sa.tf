// ======================
// create service account
// ======================
resource "yandex_iam_service_account" "k8s_master_sa" {
  name        = "sa-k8s-master-kubedoom"
  description = "service account to manage k8s masters"
}

resource "yandex_resourcemanager_folder_iam_member" "service_account_master" {
  folder_id = var.my_folder_id
  member    = "serviceAccount:${yandex_iam_service_account.k8s_master_sa.id}"
  role      = "admin"
}

resource "yandex_iam_service_account" "k8s_node_sa" {
  name        = "sa-k8s-nodes-kubedoom"
  description = "service account to manage k8s nodes"
}
resource "yandex_resourcemanager_folder_iam_member" "service_account_node" {
  folder_id = var.my_folder_id
  member    = "serviceAccount:${yandex_iam_service_account.k8s_node_sa.id}"
  role      = "container-registry.images.puller"
}

resource "null_resource" "iam_sleep" {
  provisioner "local-exec" {
    command = "sleep 5"
  }
}