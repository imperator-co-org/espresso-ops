<div align="center" text-align="center" width="100%">
    <img src="./logo/imperator.png"  alt="" height=30/>
    <img src="./logo/espresso.png" alt="" height=30 />
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
- We are growing and learning a lot.

If you love this project, please consider giving it a ⭐.

# Discussion / Ask for Help
Feel free to create a github issue to discussion your thought. Our team will try to support as much as we can


# About us

We are [Imperator.co](https://imperator.co), a leading blockchain infrastructure-as-a-service provider specializing in Proof-of-Stake (PoS) validation and advanced data solutions. Our team brings a wealth of expertise to the ecosystem, offering a full range of services from PoS validation to custom data engineering, tailored RPC nodes, APIs and Whitelabel solutions.

With a proven track record of safeguarding over $300M in assets across 50+ blockchains, we proudly serve both institutional and retail users with unwavering reliability, backed by a Service Level Agreement (SLA) ensuring 99.9% uptime. Our clients include industry leaders like Osmosis, Axelar, and CoinGecko, and we are committed to supporting the growth and security of decentralized networks.

This public repository is a contribution to the ecosystem, reflecting our dedication to advancing blockchain technology through open collaboration, security, and efficiency. Our small yet agile team continues to push boundaries to ensure client success and the sustainability of blockchain infrastructure.


