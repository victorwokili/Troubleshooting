### Setting Up SSH Key-Based Authentication on Mac

To avoid entering your password every time you connect to your server using Visual Studio on your Mac, you can set up SSH key-based authentication. Follow these steps:

1. **Generate SSH Key**:
   - Open a terminal on your Mac.
   - Run the following command to generate an SSH key pair:
     ```bash
     ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
     ```
   - Press Enter to accept the default file location.
   - Optionally, set a passphrase for added security.

2. **Copy Public Key to Server**:
   - Run the command:
     ```bash
     ssh-copy-id username@server_ip
     ```
   - Replace `username` with your server username and `server_ip` with the IP address or hostname of your server.
   - Enter your server password when prompted.

3. **Test SSH Connection**:
   - Run the command:
     ```bash
     ssh username@server_ip
     ```
   - If successful, you should log in without being prompted for a password.

4. **Optional: Disable Password Authentication**:
   - For added security, you can disable password authentication and only allow SSH key-based authentication on your server. 
   - This can be configured in the SSH server configuration file (`sshd_config`).

By following these steps, you can set up SSH key-based authentication and avoid entering your password every time you connect to your server using Visual Studio or any other SSH client on your Mac.
