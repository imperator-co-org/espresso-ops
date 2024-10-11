# Espresso Node Docker Role

Installs, updates and configures Espresso with Docker deployment style 

# Variables
All the variables has default value. Your node should run without any modification
To customize, feel free to change these value below
Default values are from `testnet`
```yaml
# Docker image info
node_version: 20240925-patch1

# Command default value
espresso_sequencer_api_port: 80
espresso_sequencer_hotshot_event_streaming_api_port: 22001
espresso_sequencer_libp2p_port: 7000
use_local_db: true
espresso_role:
  lightweight:
    command: sequencer -- http -- catchup -- status
    env:
      ESPRESSO_SEQUENCER_ORCHESTRATOR_URL: https://orchestrator-UZAFTUIMZOT.decaf.testnet.espresso.network
      ESPRESSO_SEQUENCER_CDN_ENDPOINT: cdn.decaf.testnet.espresso.network:1737
      ESPRESSO_STATE_RELAY_SERVER_URL: https://state-relay.decaf.testnet.espresso.network
      ESPRESSO_SEQUENCER_GENESIS_FILE: /genesis/decaf.toml
      RUST_LOG: "warn,libp2p=off"
      RUST_LOG_FORMAT: "json"
      ESPRESSO_SEQUENCER_STATE_PEERS: https://query.decaf.testnet.espresso.network
      ESPRESSO_SEQUENCER_L1_PROVIDER: https://go.getblock.io/1454992412334bb09d5d8282d000fb1c 
      ESPRESSO_SEQUENCER_API_PORT: "{{ espresso_sequencer_api_port }}"
      ESPRESSO_SEQUENCER_LIBP2P_BIND_ADDRESS: 0.0.0.0:{{ espresso_sequencer_libp2p_port }}
      ESPRESSO_SEQUENCER_LIBP2P_ADVERTISE_ADDRESS: "{{ ip_addr }}:{{ espresso_sequencer_libp2p_port }}"
      ESPRESSO_SEQUENCER_STORAGE_PATH: "/root/{{folder}}/store"
      ESPRESSO_SEQUENCER_KEY_FILE: "/root/{{folder}}/keys/0.env"
  da:
    command: sequencer -- storage-sql -- http -- catchup -- status -- query
    env:
      ESPRESSO_SEQUENCER_ORCHESTRATOR_URL: https://orchestrator-UZAFTUIMZOT.decaf.testnet.espresso.network
      ESPRESSO_SEQUENCER_CDN_ENDPOINT: cdn.decaf.testnet.espresso.network:1737
      ESPRESSO_STATE_RELAY_SERVER_URL: https://state-relay.decaf.testnet.espresso.network
      ESPRESSO_SEQUENCER_GENESIS_FILE: /genesis/decaf.toml
      ESPRESSO_SEQUENCER_POSTGRES_PRUNE: "true"
      ESPRESSO_SEQUENCER_IS_DA: "true"
      RUST_LOG: "warn,libp2p=off"
      RUST_LOG_FORMAT: "json"
      ESPRESSO_SEQUENCER_STATE_PEERS: https://query.decaf.testnet.espresso.network
      ESPRESSO_SEQUENCER_API_PEERS: https://query.decaf.testnet.espresso.network
      ESPRESSO_SEQUENCER_L1_PROVIDER: https://go.getblock.io/1454992412334bb09d5d8282d000fb1c 
      ESPRESSO_SEQUENCER_API_PORT: "{{ espresso_sequencer_api_port }}"
      ESPRESSO_SEQUENCER_LIBP2P_BIND_ADDRESS: 0.0.0.0:{{ espresso_sequencer_libp2p_port }}
      ESPRESSO_SEQUENCER_LIBP2P_ADVERTISE_ADDRESS: "{{ ip_addr }}:{{ espresso_sequencer_libp2p_port }}"
      ESPRESSO_SEQUENCER_STORAGE_PATH: "/root/{{folder}}/store"
      ESPRESSO_SEQUENCER_KEY_FILE: "/root/{{folder}}/keys/0.env"
      ESPRESSO_SEQUENCER_POSTGRES_HOST: sequencer-db
      ESPRESSO_SEQUENCER_POSTGRES_USER: root
      ESPRESSO_SEQUENCER_POSTGRES_PASSWORD: password
      ESPRESSO_SEQUENCER_POSTGRES_DATABASE: sequencer
  archival:
    command: sequencer -- storage-sql -- http -- catchup -- status -- query -- state
    env:
      ESPRESSO_SEQUENCER_ORCHESTRATOR_URL: https://orchestrator-UZAFTUIMZOT.decaf.testnet.espresso.network
      ESPRESSO_SEQUENCER_CDN_ENDPOINT: cdn.decaf.testnet.espresso.network:1737
      ESPRESSO_STATE_RELAY_SERVER_URL: https://state-relay.decaf.testnet.espresso.network
      ESPRESSO_SEQUENCER_GENESIS_FILE: /genesis/decaf.toml
      ESPRESSO_SEQUENCER_IS_DA: true
      ESPRESSO_SEQUENCER_ARCHIVE: true
      RUST_LOG: "warn,libp2p=off"
      RUST_LOG_FORMAT: "json"
      ESPRESSO_SEQUENCER_STATE_PEERS: https://query.decaf.testnet.espresso.network
      ESPRESSO_SEQUENCER_API_PEERS: https://query.decaf.testnet.espresso.network
      ESPRESSO_SEQUENCER_L1_PROVIDER: https://go.getblock.io/1454992412334bb09d5d8282d000fb1c 
      ESPRESSO_SEQUENCER_API_PORT: "{{ espresso_sequencer_api_port }}"
      ESPRESSO_SEQUENCER_LIBP2P_BIND_ADDRESS: 0.0.0.0:{{ espresso_sequencer_libp2p_port }}
      ESPRESSO_SEQUENCER_LIBP2P_ADVERTISE_ADDRESS: "{{ ip_addr }}:{{ espresso_sequencer_libp2p_port }}"
      ESPRESSO_SEQUENCER_STORAGE_PATH: "/root/{{folder}}/store"
      ESPRESSO_SEQUENCER_KEY_FILE: "/root/{{folder}}/keys/0.env"
      ESPRESSO_SEQUENCER_POSTGRES_HOST: sequencer-db
      ESPRESSO_SEQUENCER_POSTGRES_USER: root
      ESPRESSO_SEQUENCER_POSTGRES_PASSWORD: password
      ESPRESSO_SEQUENCER_POSTGRES_DATABASE: sequencer

# Docker driver config
docker_log_driver: "json-file"   # Default log driver
docker_log_opt_key: "max-size"   # Example log option key
docker_log_opt_value: "10m" 
```

Sensitive value:`ansible-vault` or remote vaults are recommened for these sensitive values

- `espresso_sequencer_key`: your key will be read from `espresso_sequencer_key`. Feel free to run `create_key` mode to create the key. Then store the content of the key in that variable. 
- database credential for DB node. Please use the following format as we inject it to docker-compose.yml env
```yaml
espresso_role:
  da:
    env:
      ESPRESSO_SEQUENCER_POSTGRES_PASSWORD: 
      ESPRESSO_SEQUENCER_POSTGRES_USER: 
      ESPRESSO_SEQUENCER_POSTGRES_DATABASE: 
      ESPRESSO_SEQUENCER_POSTGRES_HOST: 
```
Note: Ansible should use `hash_behaviour = merge` to work with nested attributes

# Usage

This role supports 2 mode:
- `espresso_prepare`: use for node base installation. Usually with common tools such as docker, jq, and default node_exporter
- `espresso_install`: use for first installation or update. use `role` to define the node type you want. Supported value: `lightweight|da|archival`
- `espresso_reset`: use for testnet only. Reset multiple nodes at the same time
- `espresso_create_key`: use for generating keys. This mode will save the keys next to your playbook location

To use the role:
```bash
git clone https://github.com/imperator-co-org/espresso-ops
```

On your ansible repo, create a file named: `requirements.txt`.
```txt
---
- name: role_espresso_node
  src: git+file:///[ESPRESSO-OPS-FOLDER]/ansible
```
Fetch the role by:
```bash
ansible-galaxy install --force -r requirements.yml -p ./roles/
```

To include the role:
```yaml
- hosts: "{{ nodes }}"
  gather_facts: true
  roles:
    - role: role_espresso_node
  vars:
    - espresso_mode: install|prepare|create_key|reset
    w
    - role: lightweight|da|archival
```
My suggestion is use the `espresso_mode` in the order below:
- `prepare`: setup basic tools + docker
- `create_key`: get your node key
- `install`: install/update the espresso docker
