
//==============================================
// Create kubedoom resources from manifest files
//==============================================
resource "kubernetes_manifest" "namespace" {
  provider = kubernetes
  manifest = yamldecode(file("kubedoom/manifest/namespace.yaml"))
}

resource "kubernetes_manifest" "sa" {
  provider = kubernetes
  manifest = yamldecode(file("kubedoom/manifest/sa.yaml"))
  depends_on = [
    kubernetes_manifest.namespace
  ]
}

resource "kubernetes_manifest" "deployment" {
  provider = kubernetes
  manifest = yamldecode(file("kubedoom/manifest/deployment.yaml"))
  depends_on = [
    kubernetes_manifest.sa
  ]
}

resource "kubernetes_manifest" "rbac" {
  provider = kubernetes
  manifest = yamldecode(file("kubedoom/manifest/rbac.yaml"))
  depends_on = [
    kubernetes_manifest.deployment
  ]
}