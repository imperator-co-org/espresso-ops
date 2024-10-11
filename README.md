<div align="center" width="100%">
    <img src="https://avatars.githubusercontent.com/u/81272306?v=4" width="128" alt="" />
    <img src="./logo/espresso.png" width="128" alt="" />
</div>

# Espresso All in One Repository
Module that allows you to deploy, install and update espresso.

- `terraform`: A terraform module that provision 4 nodes. It comes with 2 examples `mainnet_da_prod` and `testnet_da`. Feel free to create your own config and customize number of nodes based on your need
- `ansible`: A simple playbook that prepares and installs the espresso services to our cluster with `docker compose` style.
- `monitor`: A dedicated folder to setup monitor stack for espresso. We use grafana/prometheus/alertmanager
- `playbook`: Common playbooks for operators to use 

Please navigate to each folder to find how to use and customize it.

# Motivation
- We are the builder, blockchain addict and we love to contribute back to Espresso community
- We are growing and learning a lot
If you love this project, please consider giving it a ⭐.

# Discussion / Ask for Help
Feel free to create a github issue to discussion your thought. Our team will try to support as much as we can

# TODO
- [ ] Support multiple public clouds (GCP, Azure)
- [ ] Better dashboard, better alerts threshold
- [ ] Cost estimation
