//==============================================
// Create dummy pods to play with
//==============================================
resource "kubernetes_manifest" "hello" {
  provider = kubernetes
  manifest = yamldecode(file("hello.yaml"))
}
// create load balancer for dummy web pods
resource "kubernetes_manifest" "lb" {
  provider = kubernetes
  manifest = yamldecode(file("lb.yaml"))
}