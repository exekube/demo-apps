#!/bin/bash

ns=kube-system

alias helm="helm --tiller-namespace $ns \
--tls --tls-verify \
--tls-ca-cert $TF_VAR_secrets_dir/$ns/_helm/ca.cert.pem \
--tls-cert $TF_VAR_secrets_dir/$ns/_helm/helm.cert.pem \
--tls-key $TF_VAR_secrets_dir/$ns/_helm/helm.key.pem"
