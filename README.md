# explore-2026

NSX-T policies for the acme workload. The [terraform/](terraform/) folder
is the Terraform root module - it configures the single `nsxt` provider
instance ([terraform/provider.tf](terraform/provider.tf)) and calls two child
modules, split out so each policy can be reasoned about and applied
independently:

- [terraform/antrea-policy/](terraform/antrea-policy/) - the ACNP (Antrea
  Cluster Network Policy) governing pod-to-pod traffic inside the Kubernetes
  cluster.
- [terraform/database-policy/](terraform/database-policy/) - the DFW policy
  locking down the VM-based database tier.

Both modules inherit the root's provider configuration automatically -
neither declares its own `provider` block. Run Terraform from the
`terraform/` folder. To apply the two policies one after another against the
shared state, target each module in turn:

```
cd terraform
terraform apply -target=module.antrea_policy   # frontend/backend allow rules first
terraform apply                                 # then database_policy (and anything else pending)
```
