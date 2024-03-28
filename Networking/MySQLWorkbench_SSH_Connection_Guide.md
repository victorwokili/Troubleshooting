# Comprehensive Guide to Connecting to MySQL Using SSH Tunneling and Configuration File

This document outlines two methods to securely connect to a MySQL database server hosted behind a bastion host, leveraging SSH tunneling for encrypted communication. The guide delineates using direct TCP/IP over SSH and a standard TCP/IP connection facilitated by SSH configuration for ease of management.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Method 1: Direct TCP/IP over SSH](#method-1-direct-tcpip-over-ssh)
  - [Creating an SSH Tunnel Manually](#creating-an-ssh-tunnel-manually)
  - [Connecting to MySQL Using MySQL Workbench](#connecting-to-mysql-using-mysql-workbench)
- [Method 2: TCP/IP Connection via SSH Configuration (Preferred)](#method-2-tcpip-connection-via-ssh-configuration-preferred)
  - [Setting Up an SSH Configuration File](#setting-up-an-ssh-configuration-file)
  - [Connecting to MySQL Using MySQL Workbench](#connecting-to-mysql-using-mysql-workbench-1)
- [Conclusion](#conclusion)
- [Additional Resources](#additional-resources)

## Prerequisites


Before proceeding, ensure you have:

- **MySQL Server**: Access to a MySQL database server.
- **SSH Credentials**: Valid SSH credentials for your remote server and any intermediary (jump) host.
- **MySQL Workbench**: MySQL Workbench or another database client installed on your local machine.
- **Creds**: Knowledge of your MySQL database username and password.
- **OpenSSH 7.3+**: A recent version of OpenSSH on your local machine to use the ProxyJump feature.

## Understanding SSH Tunneling

SSH tunneling creates an encrypted SSH connection between your local machine and a remote server, which can securely forward traffic to and from the MySQL server. This method is crucial for accessing databases securely when the database is not exposed directly to the internet or when accessing through a secure channel is required.

## Method 1: Direct TCP/IP over SSH

This method directly creates an SSH tunnel for securing your MySQL connection. It's straightforward but requires manual setup each time you connect.

### Creating an SSH Tunnel Manually

To establish an SSH tunnel, execute the following command in your terminal:

```sh
ssh -L [LOCAL_PORT]:[FINAL_DESTINATION]:[DESTINATION_PORT] -J [PROXY_USER]@[PROXY_HOST] [FINAL_DESTINATION_USER]@[FINAL_DESTINATION]
```

Replace the placeholders accordingly. This command sets up a tunnel from your local machine's port `[LOCAL_PORT]` through a bastion host `[PROXY_HOST]` to the MySQL server `[FINAL_DESTINATION]` listening on `[DESTINATION_PORT]`.


### Connecting to MySQL Using MySQL Workbench

After setting up the SSH tunnel:

1. Open MySQL Workbench and create a new connection.
2. Choose the "Standard TCP/IP over SSH" connection method.
3. Enter the SSH and MySQL details as prompted:
   - SSH Hostname: `[PROXY_HOST]` and port (usually 22).
   - SSH Username: `[PROXY_USER]`.
   - MySQL Hostname: `127.0.0.1` (localhost, as the tunnel endpoint is your local machine).
   - MySQL Port: `[LOCAL_PORT]`, matching the tunnel's local port.
4. Test and save the connection.

### Command Breakdown
- `ssh`: Initiates an SSH connection.
- `-L [LOCAL_PORT]:[FINAL_DESTINATION]:[DESTINATION_PORT]`: Specifies local port forwarding.
  - `[LOCAL_PORT]`: Local port on your machine to forward from.
  - `[FINAL_DESTINATION]`: IP address or hostname of the MySQL server.
  - `[DESTINATION_PORT]`: Port on which the MySQL server is listening, typically `3306`.
- `-J [PROXY_USER]@[PROXY_HOST]`: Specifies the jump host (bastion) to tunnel through.
  - `[PROXY_USER]@[PROXY_HOST]`: SSH user and hostname/IP of the proxy server.
- `[FINAL_DESTINATION_USER]@[FINAL_DESTINATION]`: Final SSH user and destination.



## Method 2: TCP/IP Connection via SSH Configuration (Preferred)

Using an SSH configuration file simplifies connections and is particularly useful for frequent access, supporting multiple SSH options, including proxy jumps.

### Setting Up an SSH Configuration File

Edit or create your SSH configuration in `~/.ssh/config` with the following entry:

```md
Host mydb
  HostName [FINAL_DESTINATION]
  User [FINAL_DESTINATION_USER]
  Port [DESTINATION_PORT]
  ProxyJump [PROXY_USER]@[PROXY_HOST]
  LocalForward [LOCAL_PORT] 127.0.0.1:[DESTINATION_PORT]
```

This configuration enables a simplified `ssh mydb` command to establish the connection, handling both the jump and port forwarding.

### Connecting to MySQL Using MySQL Workbench

For this method, configure MySQL Workbench to connect using "Standard (TCP/IP)" with:


For this preferred method, you connect as if the MySQL server were local:

1. Set up your SSH tunnel using the configuration with a simple `ssh mydb` command.
2. In MySQL Workbench, create a new connection with "Standard (TCP/IP)" method.
3. Enter `127.0.0.1` as the hostname and the `[LOCAL_PORT]` you specified in your SSH config as the port.
- Hostname: `127.0.0.1`
- Port: `[LOCAL_PORT]`
- Username and password as per your MySQL credentials.

This method is preferred for its ease of use and management, especially for complex or multiple connections.


### SSH Configuration Explained

- `Host mydb`: Alias for the connection, allowing you to use `ssh mydb` for simplicity.
- `HostName [FINAL_DESTINATION]`: Specifies the final MySQL server's hostname or IP.
- `User [FINAL_DESTINATION_USER]`: SSH username for the final destination server.
- `Port [DESTINATION_PORT]`: Port number for the SSH service on the destination, usually `22`.
- `ProxyJump [PROXY_USER]@[PROXY_HOST]`: Defines the proxy jump host for reaching the destination server.
- `LocalForward [LOCAL_PORT] 127.0.0.1:[DESTINATION_PORT]`: Forwards connections from `[LOCAL_PORT]` on your local machine to `[DESTINATION_PORT]` on the destination server, routed through the SSH tunnel.




## Conclusion

Both methods provide secure means to access MySQL databases behind bastion hosts, leveraging SSH for encryption. Method 2, using an SSH configuration file, offers simplicity and manageability, making it the preferred approach for regular use.

## Additional Resources

- [MySQL Workbench Documentation](https://dev.mysql.com/doc/workbench/en/)
- [OpenSSH Client Configuration](https://man.openbsd.org/ssh_config)
