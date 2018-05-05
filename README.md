# demo-apps-project

The *demo-apps-project* deploys various web applications onto Kubernetes / GCP using the Google Kubernetes Engine (GKE).

## Networking

### Privately expose your applications

By default, this project ships with minimally configured networking for simplicity and ease of setup, though our services will be available only privately via `kubectl proxy` (from within the cluster). For this project, you can enable the proxy by typing in your shell

```sh
docker-compose up
```

Use can then access the applications using the "Private address" links below.

### Publicly expose your applications

If we want to expose our services (applications) on the public Internet, we will need to:

1. Create an [external static IP address](/) for `nginx-ingress` service.
2. Enable `nginx-ingress` (Kubernetes LoadBalancer type of service)
3. Create DNS records to point clients to this address
4. Use [cert-manager](https://github.com/jetstack/cert-manager) to enable TLS for the domains
5. Enable `Ingress` resources for our Helm releases.

Use [this pull request](/) as an example of how to set up production networking.

There is also a step-by-step tutorial: <https://docs.exekube.com/in-practice/production-networking>


## Modules

### Base modules

This project uses the Exekube [base-project](https://github.com/exekube/base-project) as boilerplate.

Modules from base-project:

- gke-network
- gke-cluster
- administration-tasks

### modules/nginx-ingress

We use nginx-ingress as our ingress controller for the applications.

### modules/cert-manager

We use cert-manager to acquire Let's Encrypt TLS certificates to enable HTTPS for publicly available appications.

### modules/guestbook

Guestbook is a canonical example of a Kubernetes deployment

- Private address: <http://localhost:8001/api/v1/namespaces/default/services/frontend:80/proxy/>
- Public address: [read instructions above](#publicly-expose-your-applications)

### modules/forms-app

A custom React app to test out Istio ingress and auto-injection

- Private address: <http://localhost:8001/api/v1/namespaces/default/services/forms-app-nginx-react:80/proxy/>
- Public address: [read instructions above](#publicly-expose-your-applications)
