# Demo Exekube Project: demo-apps-project

An example cloud project built with the [Exekube framework](https://github.com/exekube/exekube)

> :warning:
> This is a work in progress
> :warning:

The exekube/demo-apps-project contains configuration for deploying a Kubernetes cluster onto the Google Cloud Platform (GCP), as well as Kubernetes resources (via Helm charts) that result in this software released into the cloud:

- A React application served from an NGINX deployment, behind gce-ingress (GCP HTTP(S) Load Balancer) with Google Cloud CDN enabled

## Project structure

The `live` directory contains configuration for every environment (dev, stg, prod) for this product. The `live/terraform.tf` directory contains Terraform / Terragrunt configuration common for every environment. The `live/.env` file contains variables common for every environment.

```sh
├── live/
│   ├── dev/
│   ├── stg/
│   ├── prod/
│   ├── .env # variables common for every environment
│   └── terraform.tfvars # terraform config common to every environment
```

## Environment (product environment) configuration

Every environment (dev, stg, test, prod, etc.) directory is broken down into resources (cloud resources) of these categories:

- project (cloud project resources, e.g. network, subnets, firewall rules, dns)
- kube (cluster and cluster workloads, config, storage, and networking resources)
- secrets (secrets specific to this environment)
- .env (environment-specific variables common to several modules)

```
live/
├── dev/
│   ├── project/
│   ├── kube/
│   ├── secrets/
│   ├── .env
│   └── concourse-pipelines.yaml
├── prod/
│   ├── project/
│   ├── kube/
│   ├── secrets/
│   ├── .env
│   └── concourse-pipelines.yaml
├── .env
└── terraform.tfvars
```

... to be continued ...
