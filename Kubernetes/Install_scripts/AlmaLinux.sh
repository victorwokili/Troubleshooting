#!/bin/bash

# Exit on any error
set -e

# Update the system
# echo "Updating the system..."
# sudo dnf update -y

# Set the hostname
echo "Setting the hostname to XXXXXX..."
sudo hostnamectl set-hostname XXXXXX

#Uninstall any existing RKE2 installation
if [ -x "/usr/bin/rke2-uninstall.sh" ]; then
    echo "RKE2 binary found. Proceeding with uninstallation..."
    sudo /usr/bin/rke2-uninstall.sh
else
    echo "RKE2 is not installed. Proceeding with the installation..."
fi

# Download the RKE2 install script
echo -e "\n\n\n----------"
echo -e "Downloading the RKE2 install script..."
echo -e "----------"
curl -sfL https://get.rke2.io --output install.sh
chmod +x install.sh

# Install RKE2
echo -e "\n\n\n----------"
echo -e "Installing RKE2..."
echo -e "----------"
sudo ./install.sh

# Enable and start RKE2
echo -e "\n\n\n----------"
echo -e "Enabling and starting RKE2... "
echo -e "----------"
sudo systemctl enable rke2-server.service
sudo systemctl start rke2-server.service

# Wait a bit for RKE2 to initialize
echo -e "\n\n\n----------"
echo -e "Waiting for RKE2 to initialize..."
echo -e "----------"
sleep 30

# Configure kubectl
echo -e "\n\n\n----------"
echo "Configuring kubectl..."
echo -e "----------"
mkdir -p $HOME/.kube
sudo cp /etc/rancher/rke2/rke2.yaml $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
export KUBECONFIG=$HOME/.kube/config
echo 'export KUBECONFIG=$HOME/.kube/config' >> $HOME/.bashrc

# Check if the node is ready
echo -e "\n\n\n----------"
echo "Checking if the node kind-vm-1 is ready..."
echo -e "----------\n\n\n"
kubectl get nodes

echo -e "\n\n\n----------"
echo "RKE2 installation and configuration on AlmaLinux with node name 'kind-vm-1' completed successfully."
echo -e "----------\n\n\n"
