
# Corrective Guide: UI Container Connectivity via Proxy

## Introduction

Dive into a detailed account of a troubleshooting expedition that unfolded during an effort to log into a UI container with a Container Proxy Firefox add-on. This narrative is not just a walkthrough but a testament to the pivotal moments and resolutions drawn from real-world encounters.

## The Challenge

The task at hand involved interfacing with a UI container through the Firefox add-on, aimed at facilitating direct modifications within the container. Despite a configuration that seemed error-free, the anticipated changes failed to materialize, prompting a thorough investigation.

## Discovery Phase

Initial beliefs suggested a misconfiguration on the local macOS machine, especially concerning the routing of web traffic. However, the pivotal revelation came from contrasting the `/etc/hosts` configurations between the local machine and the virtual machine (VM).

### The Misdirection

A meticulous comparison uncovered that the Fully Qualified Domain Name (FQDN) set in the `values.yaml` file of the parent Helm chart, under the global section, was inaccurately pointing to another host's IP address. This misalignment resulted in changes being dispatched to an unintended destination.

## Troubleshooting Steps

1. **Inspect Container Proxy Configuration:** Ensure the add-on settings align with the target container's network specifics.
2. **Review Helm Chart's Network Settings:** Delve into the `values.yaml` file, focusing on the `global` section for any discrepancies in network configurations.
3. **Examine VM's `/etc/hosts` File:** Execute `cat /etc/hosts` within the VM to scrutinize domain-to-IP mappings, identifying any inaccuracies.
4. **Cross-reference Local Machine's SSH Config:** Compare the SSH configuration files between the local machine and the VM to pinpoint divergences in network pathways.

## Resolution Strategy

Adjusting the FQDN within the Helm chart's `values.yaml` file to mirror the correct VM's IP address rectified the misrouting, ensuring changes were directed appropriately.

## Decoding `/etc/hosts`

The `/etc/hosts` file acts as a static table for hostname-to-IP resolution, granting a machine the ability to map domain names to IP addresses internally, bypassing DNS lookups. This file played a crucial role in tracing the root cause by highlighting the discrepancy in expected versus actual network paths.

## Decoding `FQDN`

A Fully Qualified Domain Name (FQDN) specifies the exact location of a device on the Internet, including both the hostname and the domain name. In the troubleshooting scenario described, the FQDN was misconfigured in a values.yaml file, mistakenly directing changes intended for a specific container to the wrong host. Correcting the FQDN to point to the intended host's IP address resolved the issue, underscoring the FQDN's crucial role in accurately routing network traffic. This situation highlights the importance of precise configuration and validation of FQDN settings in network operations.

## Detailed SSH Configuration Breakdown

### VM Configuration File on MacOS
```
#this is for my bastion:
Host vic-bastion
User victor.wokili@luf.network
HostName bh.gard.luf.network
Port 22
#DynamicForward 1080

Host vic-vm1
User user
HostName 192.168.11.7
ProxyJump vic-bastion
DynamicForward 2080
LocalForward 3306 127.0.0.1:3306


Host kind-vm2
User user
HostName 192.168.101.98
ProxyCommand ssh -W %h:%p reach-bastion

```

### Bastion Configuration
**vic-bastion:**
- **User:** Designated login username `victor.wokili@luf.network`, indicating the user's domain.
- **HostName:** The bastion's Fully Qualified Domain Name (FQDN), `bh.gard.luf.network`, acts as a secure entry point for SSH connections.
- **Port:** Specifies the standard SSH port (`22`), defining the port on which the bastion listens for incoming SSH connections.


### VM Configuration
**vic-vm1 Configuration:**
- **User:** Specifies the login username as 'user'.
- **HostName:** The IP address `192.168.11.7` indicates where the SSH session will be directed.
- **ProxyJump:** This command uses `vic-bastion` as an intermediary, allowing for a direct SSH connection to the final destination without manually logging into the bastion.
- **DynamicForward:** Establishes a SOCKS proxy server on local port 2080, dynamically forwarding traffic through the SSH connection, enabling secure browsing through the server.
- **LocalForward:** Forwards traffic from the local machine's port 3306 to port 3306 on `127.0.0.1` of the remote server, typically used for accessing remote database services as if they were locally available.

**kind-vm2 Configuration:**
- **User:** Login username set as 'user'.
- **HostName:** Specifies the IP address `192.168.101.98` for the SSH session's target.
- **ProxyCommand:** Facilitates an SSH connection through another server (`reach-bastion`). The `-W %h:%p` option forwards the SSH protocol to the final destination, enabling seamless connectivity through an intermediate host.

