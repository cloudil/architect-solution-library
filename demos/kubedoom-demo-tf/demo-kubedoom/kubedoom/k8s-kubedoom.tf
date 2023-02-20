resource "kubernetes_manifest" "kubedoom" {
  for_each = fileset("./kubedoom/manifest", "*.yaml")
  manifest = templatefile("./kubedoom/manifest${each.value}", { namespace = "kubedoom" })
  namespace = "kubedoom"
}
