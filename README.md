# explore-2026

NSX-T policies for the 3tierapp workload. This directory is the Terraform
root module - it configures the single `nsxt` provider instance
([provider.tf](provider.tf)) and calls two child modules, split out so each
policy can be reasoned about and applied independently:

- [antrea-policy/](antrea-policy/) - the ACNP (Antrea Cluster Network Policy)
  governing pod-to-pod traffic inside the Kubernetes cluster.
- [database-policy/](database-policy/) - the DFW policy locking down the
  VM-based database tier.

Both modules inherit the root's provider configuration automatically -
neither declares its own `provider` block. To apply them one after another
against the shared state, target each module in turn:

```
terraform apply -target=module.antrea_policy   # frontend/backend allow rules first
terraform apply                                 # then database_policy (and anything else pending)
```
