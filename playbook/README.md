# Espresso common playbook
This file contains all the common playbooks we normally use to build and operate espressso sequencer.

Contact 
- Official website: https://www.espressosys.com/
- Slack: Private channel for validators
- Telegram: TBD


## 1. Setup new cluster of node
- Step 1. Provision infrastructure. At the momment, each operator needs 4 nodes that will be located all over the world depends on the private sheet that allocates the region to each operator.
Ref: [Create infrastructure on AWS](../terraform/README.md)

- Step 2. Install necessary applications to each node
Ref: [Espresso Ansible playbook](../ansible/README.md)

- Step 3. Each node will come with an Public IP. Please assign an domain name to each node.
Normally, the service port is running at 80. Feel free to run some tests 

- Step 4. Add espresso to your monitoring stack.
On our team, we have:
- `node_exporter`: takes care node metrics and be fetched by our prometheus cluster
- `cadvisor`: collects docker container metrics  and be fetched by our prometheus cluster
- `custom_scape_rule`: collects espresso application metrics and be fetched by our prometheus

We provide our first version of [grafana dashboard](../monitor/README.md). Feel free to test and customize to match your needs.

- Step 5. Add alerts. #TODO

## 2. Update sequencer
- Step 1. Find the latest tag of sequencer image. It can be from slack or official doc. 
- Step 2. Update `node_version` attribute to new tag. For example. On testnet, we are set `node_version: 20240925-patch1`
- Step 3.  Run your playbook 

## 3. Check logs
Currently, the default value of log level is `warn`. Sometimes, the espresso will need some help from any validators to debug.
To check the logs:

Without log system:
```bash
# With docker style
docker [container_id] logs

# With k8s
kubectl logs [pod]
```



