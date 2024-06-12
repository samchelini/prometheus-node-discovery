# prometheus-node-discovery

Scans the network for nodes running prometheus exporters and generates JSON for file-based service discovery. Assumes DNS reverse lookup zones exist.

Usage: edit TARGET_PORT and TARGET_NETWORK and run ./discover-nodes.sh
