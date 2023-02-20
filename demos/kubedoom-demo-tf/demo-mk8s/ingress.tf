// Ingress rule for VNC access to port 5900
resource "yandex_vpc_security_group_rule" "ingress" {
  security_group_binding = yandex_vpc_security_group.k8s_public_services.id
  direction              = "ingress"
  description            = "VNC access to port 5900"
  v4_cidr_blocks         = ["0.0.0.0/0"]
  port                   = 5900
  protocol               = "TCP"
}
