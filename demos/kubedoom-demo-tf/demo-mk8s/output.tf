# Output values

data "yandex_compute_instance_group" "my_group" {
  instance_group_id = yandex_kubernetes_node_group.nodes.instance_group_id
}

output "instance_external_ip" {
  description = "Public IP addresses for VNC connection"
  value = "${data.yandex_compute_instance_group.my_group.instances.*.network_interface.0.nat_ip_address}"
}

/*
output "instance_group_ingresses_public_ips" {
  description = "Public IP addresses for ingress-nodes"
  value = yandex_compute_instance_group.k8s-ingresses.instances.*.network_interface.0.nat_ip_address
}

output "load_balancer_public_ip" {
  description = "Public IP address of load balancer"
  value = yandex_lb_network_load_balancer.k8s-load-balancer.listener.*.external_address_spec.0.address
}
*/