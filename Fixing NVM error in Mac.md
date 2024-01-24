# How to Fix- zsh command not found nvm error in Mac – Reason and Solution

The zsh command not found: nvm error is a common issue when attempting to use the nvm command within the Zsh shell, but the shell cannot find it in its list of recognized commands. This error prevents you from managing Node.js versions and executing nvm-related commands. 

Several reasons can lead to the zsh command not found: nvm error on your Mac, including missing or inaccessible nvm installation, or incorrect PATH configuration. If the directory containing the nvm executable is not included in the PATH environment variable, the shell won’t be able to locate and execute the nvm command, resulting in the command not found error.

To fix the zsh: command not found: nvm error, follow these steps:

1. **Install nvm**: Begin by installing nvm on your Mac from Homebrew with `brew install nvm`. Note: To perform this step you must have Homebrew installed on your Mac.

2. **Check for the Installed Package**: Determine the installation path or directory of the nvm package managed by Homebrew with `brew --prefix nvm`.

3. **Open Zsh Configuration File**: Open the zshrc configuration file using the nano editor with `sudo nano /etc/zshrc`. Add the following line at the end of the zshrc file: `export NVM_DIR="$HOME/.nvm"`. `. "/usr/local/opt/nvm/nvm.sh"\`.

4. **Save the Configuration File**: Save the changes to the file using CTRL+X, add Y and press Enter. Then run `source /etc/zshrc`.

5. **Test the Installation**: Test whether the changes are successfully applied by running `nvm --version`. If the command executes without any errors and displays the version information, it indicates that the changes to nvm have been applied correctly.

Encountering the zsh command not found: nvm error in the Zsh shell on Mac can be frustrating, as it prevents you from using nvm and managing Node.js versions effectively. By following the provided solutions, including installing nvm, updating the zshrc configuration file, and testing the installation with the nvm –version command, you can resolve the error and successfully use nvm in your Zsh shell on Mac. 

### About the author

Awais Khan

I'm an Engineer and an academic researcher by profession. My interest for Raspberry Pi, embedded systems and blogging has brought me here to share my knowledge with others.
