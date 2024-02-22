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

<br> <br> <br> <br> <br>


### Customizing Terminal Prompt for Different Machines

When working with multiple terminal sessions, it can be helpful to customize the prompt to display a specific identifier for each machine you're logged into. This guide will walk you through the process of modifying your terminal prompt to include a unique identifier, allowing you to easily differentiate between different machines.

#### Step 1: Open Your Shell Configuration File

Open the `~/.bashrc` or `~/.bash_profile` file in a text editor. You can use the `nano` editor for this purpose by running:

```bash
nano ~/.bashrc
```

or 

```bash
nano ~/.bash_profile
```

#### Step 2: Modify the PS1 Variable

Locate the line that sets the PS1 variable. If you don't find it, you can add it at the end of the file. Add the following line to set the prompt format:
```bash
export PS1="\u@ControlServer \W \$ "
```

Here's what each part of the line does:

   - \u: Inserts the current username.
   - @ControlServer: Displays the string "ControlServer" as the identifier for the machine.
   - \W: Shows the current working directory (shortened to just the base directory name).
   - \$: Displays a $ for regular users and # for the root user.


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

Open a new terminal window or tab. You should now see the custom prompt with the specified identifier (ControlServer in this example) followed by the username and working directory.

Repeat these steps for each machine you want to customize the prompt on, adjusting the identifier (ControlServer in this example) to match the appropriate label for each machine. This way, you can easily differentiate between different machines when working in multiple terminal sessions.

