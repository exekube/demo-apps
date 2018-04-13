terraform {
  backend "gcs" {}
}

# ------------------------------------------------------------------------------
# PROVIDER CONFIG
# ------------------------------------------------------------------------------

resource "null_resource" "bookinfo-app" {
  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]

    command = <<EOF
kubectl apply -f \
  <(istioctl kube-inject --debug -f ${path.module}/bookinfo.yaml)
EOF
  }

  provisioner "local-exec" {
    when    = "destroy"
    command = "bash ${path.module}/cleanup.sh"
  }
}
