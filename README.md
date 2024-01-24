**lamp-stack-cli-script**

This script automates the process of deploying a LAMP (Linux, Apache, MySQL, PHP) stack on an Azure virtual machine.

Script steps:
1. Logs into Azure account.
2. Prompts user for resource group name, VM name, and admin username.
3. Checks for valid Azure resource group name, VM name, and admin username.
4. Creates a resource group in 'germanywestcentral'.
5. Creates a Ubuntu 22.04 VM with the specified name and admin username.
6. Creates Network Security Group (NSG) rules to open SSH port 22 and HTTP port 80.
7. Waits for VM deployment to succeed.
8. Shows the public IP of the VM.
9. Connects to the VM via SSH and installs Apache, MySQL, and PHP.
10. Connects to the VM for user interaction.

Usage
- Ensure you have Azure CLI installed on your machine.
- Run the script in your terminal: ./lamp_stack.sh
- Follow the prompts to enter your resource group name, VM name, and admin username.
- Wait for the script to complete the deployment.

Once the script completes, it will output the public IP of the VM. You can use this IP to access your newly deployed LAMP stack.

Note
This script automates the fingerprint confirmation for SSH connections. This is generally not recommended for security reasons. Please use this feature responsibly.

Requirements
Azure CLI
Bash shell
This script is intended to be run in a Bash shell. If you're using a different shell (like Zsh), you may need to switch to Bash before running this script.
