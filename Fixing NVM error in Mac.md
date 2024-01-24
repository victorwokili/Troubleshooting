# How to Fix- zsh command not found nvm error in Mac – Reason and Solution

![image](https://github.com/victorwokili/Troubleshooting/assets/18079443/e9c675bd-093f-4ca4-b0f2-11bb6d3622c0)

The zsh command not found: nvm error is a common issue when attempting to use the nvm command within the Zsh shell, but the shell cannot find it in its list of recognized commands. This error prevents you from managing Node.js versions and executing nvm-related commands. 

## Possible Reasons for the Zsh Command not found: nvm Error

Several reasons can lead to the zsh command not found: nvm error on your Mac, including:

### 1: Missing or Inaccessible nvm Installation

The error occurs if nvm is not installed on the system or if it is not accessible within the Zsh shell.

### 2: Incorrect PATH Configuration

Suppose the directory containing the nvm executable is not included in the PATH environment variable. In that case, the shell won’t be able to locate and execute the nvm command, resulting in the command not found error.

## Solution to Fix zsh: command not found: nvm error on Mac 

To fix the zsh: command not found: nvm error, follow the below-given steps:

### Step 1: Install nvm

Begin by installing nvm on your Mac from Homebrew with the following command:


```bash
brew install nvm
```
Note: To perform the above step you must have Homebrew installed on your Mac.

### Step 2: Check for the Installed Package

You need to determine the installation path or directory of the nvm package managed by Homebrew using the following command.
 ```bash
 brew --prefix nvm
```

### Step 3: Open Zsh Configuration File

Now open the zshrc configuration file using the nano editor via the command given below:

 **Open Zsh Configuration File**: Open the zshrc configuration file using the nano editor with 
 
 ```bash
sudo nano /etc/zshrc
 ```
 
 Add the following line at the end of the zshrc file: 
```bash
export NVM_DIR="$HOME/.nvm"  
. "/usr/local/opt/nvm/nvm.sh"\
```


### Step 4: Save the Configuration File

Once you made the necessary changes to the file, you have to save it using CTRL+X, add Y and press Enter.



```bash
source /etc/zshrc
```


### Step 5: Test the Installation

To test whether the changes are successfully applied, you must run the version command again.



```bash
nvm --version
```
 If the command executes without any errors and displays the version information, it indicates that the changes to nvm have been applied correctly.

Encountering the zsh command not found: nvm error in the Zsh shell on Mac can be frustrating, as it prevents you from using nvm and managing Node.js versions effectively. By following the provided solutions, including installing nvm, updating the zshrc configuration file, and testing the installation with the nvm –version command, you can resolve the error and successfully use nvm in your Zsh shell on Mac. 



