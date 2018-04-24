terraform {
  backend "gcs" {}
}

resource "null_resource" "ingress" {
  provisioner "local-exec" {
    command = "kubectl apply -f ${path.module}/ingress.yaml"
  }

  provisioner "local-exec" {
    when    = "destroy"
    command = "kubectl delete -f ${path.module}/ingress.yaml"
  }
}
