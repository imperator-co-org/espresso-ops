# Espresso Infrastructure Terraform module 

We are targeting this module should support multiple providers. First with AWS then more are coming.

# Usage

In `deployments` folder, each folder contains the name of the provider you want to deploy. At the momment, `aws` is only provider we support. 

- Step 1: Clone the project and change to terraform component
```bash
git clone https://github.com/imperator-co-org/espresso-ops
cd espresso-ops/terraform
```

- Step 2: Select cloud folder in `deployments`
```bash
cd deployments
# Deploy on aws
cd aws
```

- Step 3: Base on the example files, feel free to change it to match your requirements. The example files are:
    - `mainnet_da_prod.tf.example`: Contains 3 regular nodes and 1 da node on `mumbai` region. On prod or mainnet, we use RDS as database for DA node on 
    - `testnet_da.tf.example`: Contains 3 regular nodes and 1 da node on `mumbai`. On testnet, we deploy RDS instance on the same node.
    - Update your backend config

- Step 4: Authenticate to your cloud account.
- Step 5: See the changes and apply 
```bash
# See which resources will be created
terraform plan
# Apply the changes
terraform apply
```
