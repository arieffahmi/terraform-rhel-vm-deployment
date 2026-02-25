Automated deployment of RHEL VMs using HCP Terraform
=====================================================

**Overview**
- **Purpose:** Automated creation of RHEL virtual machines on vSphere using HCP Terraform and the HashiCorp `vsphere` provider.
- **Approach:** The root configuration (`main.tf`) queries datacenter, datastore, cluster, and network, then creates one or more `vsphere_virtual_machine` resources using variables from `variables.tf` and `terraform.tfvars`.

**Files**
- **`main.tf`:** Provider and VM resource definitions. See [main.tf](main.tf#L1-L200).
- **`variables.tf`:** All input variables (sensitive flags and defaults). See [variables.tf](variables.tf#L1-L200).
- **`terraform.tfvars`:** Example runtime values (keeps secrets out of VCS). See [terraform.tfvars](terraform.tfvars#L1-L50).

**Prerequisites**
- Install Terraform (compatible with the provider version pinned in `main.tf`).
- Network access to the vSphere server and valid credentials with rights to create VMs.

**Important notes**
- The configuration initializes HCP Terraform by default; you may see a provider registry warning recommending `vmware/vsphere` for newer Terraform versions — updating `required_providers` is optional but recommended when upgrading Terraform.
- Keep credentials out of source control. Use a local `terraform.tfvars` (gitignored) or environment variables.

**Variables**
- The key vSphere variables are declared in [variables.tf](variables.tf#L1-L200):
  - `vsphere_user` (string, sensitive)
  - `vsphere_password` (string, sensitive)
  - `vsphere_server` (string, sensitive)
  - `vsphere_allow_unverified_ssl` (bool, default: `true`)
  - `vsphere_api_timeout` (number, default: `10`)

**Example `terraform.tfvars`**
Replace secrets before running. Do NOT commit this file to a public repo.

```terraform
vsphere_user = "your-user@vsphere.local"
vsphere_password = "REDACTED_PASSWORD"
vsphere_server = "vc.example.local"
# other optional values can be added here or left to defaults
```

**Usage (quick commands)**
1. Initialize the working directory (this will initialize HCP Terraform if configured):

```bash
terraform init
```

2. Validate the configuration:

```bash
terraform validate
```

3. Generate and inspect an execution plan:

```bash
terraform plan -out=tfplan
terraform show -json tfplan | less
```

4. Apply the plan (use caution; this creates resources):

```bash
terraform apply "tfplan"
```

**HCP Terraform specifics**
- When you run `terraform init` in this workspace it may initialize with HCP Terraform (as seen previously). That is normal if your organization uses HCP; otherwise Terraform will initialize local providers.

**Security**
- Mark `terraform.tfvars` as gitignored. Prefer using a secure secrets manager or environment variables for CI.

**Troubleshooting**
- If you see a provider source warning, update `required_providers` in `main.tf` to `vmware/vsphere` and test with `terraform init`.

**Files to review**
- [main.tf](main.tf#L1-L200)
- [variables.tf](variables.tf#L1-L200)
- [terraform.tfvars](terraform.tfvars#L1-L50)

---
