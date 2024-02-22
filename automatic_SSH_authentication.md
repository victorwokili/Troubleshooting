# Setting Up SSH Key-Based Authentication on Mac

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

<br> <br> <br> <br> <br>


# Customizing Terminal Prompt for Different Machines

![image](https://github.com/victorwokili/Troubleshooting/assets/18079443/7ad69f0c-2179-4f4b-b843-ccbe8ceca0ac)


When working with multiple terminal sessions, it can be helpful to customize the prompt to display a specific identifier for each machine you're logged into. This guide will walk you through the process of modifying your terminal prompt to include a unique identifier, allowing you to easily differentiate between different machines.

### There a 2 Methods


## Method 1 : Using host files
### Changing Hostname in Linux (Ubuntu)

This guide provides step-by-step instructions on how to change the hostname of a Linux system (specifically Ubuntu) to `ACGcontrolserver` and how to update the `/etc/hosts` file to reflect this change.

### Changing the Hostname

#### Step 1: Set the New Hostname

Use the `hostnamectl` command with `sudo` to change the system's hostname.

```bash
sudo hostnamectl set-hostname ACGcontrolserver
```

#### Step 2: Verify the Hostname Change
After setting the new hostname, confirm the change by displaying the current hostname:

```bash
hostnamectl
```

### Updating the /etc/hosts File
#### Step 1: Edit the Hosts File
Open the /etc/hosts file in a text editor like nano. This file maps IP addresses to hostnames.

```bash
sudo nano /etc/hosts
```

### Step 2: Modify the Hosts File
Find the line in the /etc/hosts file that starts with an IP address `172.31.36.178`, ensure this is the private IP address of the machine. This line usually contains the old hostname. Replace the old hostname with ACGcontrolserver.

For example, change:

```bash
172.31.36.178    oldhostname
```

to 

```bash
172.31.36.178    ACGcontrolserver
```

### Step 3: Add the private IP addresses for other associated hosts
In this case this is a kubernetes cluster with a controlplane node (`ACGcontrol server`) and 2 worker nodes (`ACGworkernode1` and `ACGworkernode2`)
It is important to use the private IP addresses as the public IP addresses can change 

add to the host file of the associated nodes:
```bash
172.31.36.178    ACGcontrolserver
privateIP    ACGworkernode1
privateIP    ACGworkernode2
```

172.31.36.178   ACGcontrolserver
172.31.47.119   ACGworkernode1
172.31.36.253   ACGworkernode2

it will look like this: <br>
![image](https://github.com/victorwokili/Troubleshooting/assets/18079443/773c10ff-ab32-47d8-9ce6-5a0d54230921)
<br>

### Step 4: Save the Changes
After editing the file, save the changes. In nano, this is done by pressing `Ctrl + X`, then `Y` to confirm, and finally `Enter`.

### Step 5: Copy the newly added values, rinse and repate to the other node machines (depending on project)
```bash
172.31.36.178   ACGcontrolserver
172.31.47.119   ACGworkernode1
172.31.36.253   ACGworkernode2
```

For this example, copy and paste the above to `ACGworkernode1` and `ACGworkernode2`. Obviously, change values as necessary

<br><br><br> <br><br><br> 
---
<br><br><br> <br><br><br> 

## Method 2 : Using the Shell configuration file
#### Step 1: Open Your Shell Configuration File

Open the `~/.bashrc` or `~/.bash_profile` file in a text editor. You can use the `nano` editor for this purpose by running:

```bash
nano ~/.bashrc
```



#### Step 2: Find PS1 Variable: Locate the line that sets the `PS1` variable. It may look something like this:

Locate the line that sets the PS1 variable.  
```bash
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
```

Modify `PS1` Variable: Modify the `PS1` variable to set the prompt format to cloud_user@ControlServer:
```bash
PS1='\[\033[01;32m\]cloud_user@ControlServer\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
```

We effecitively got rid of `{debian_chroot:+($debian_chroot)}` and replaced `\u@\h` with `cloud_user@ControlServer\`

#### Step 3: Save and Exit

Press `Ctrl + X` to exit nano, then press `Y` to confirm the changes, and finally press `Enter` to save the file.

#### Step 4: Reload the Configuration

After saving the changes, reload the shell configuration file to apply the new prompt format:

```bash
source ~/.bashrc
```

or 

```bash
source ~/.bash_profile
```

### Step 5: Verify the Prompt

Now, whenever you open a new terminal session, the prompt should display cloud_user@ControlServer as desired.

Open a new terminal window or tab. You should now see the custom prompt with the specified identifier (ControlServer in this example) followed by the username and working directory.

Repeat these steps for each machine you want to customize the prompt on, adjusting the identifier (ControlServer in this example) to match the appropriate label for each machine. This way, you can easily differentiate between different machines when working in multiple terminal sessions.

