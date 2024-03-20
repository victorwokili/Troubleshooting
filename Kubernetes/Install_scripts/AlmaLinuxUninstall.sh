#!/bin/bash

# Exit on any error
set -e

# Uninstall RKE2 if it is installed
if [ -f /usr/local/bin/rke2-uninstall.sh ]; then
    echo "RKE2 uninstall script found. Uninstalling RKE2..."
    /usr/local/bin/rke2-uninstall.sh
elif [ -f /usr/bin/rke2-uninstall.sh ]; then
    echo "RKE2 uninstall script found in /usr/bin. Uninstalling RKE2..."
    /usr/bin/rke2-uninstall.sh
else
    echo "RKE2 is not installed or uninstall script is not found. Skipping RKE2 uninstallation."
fi

# Cleanup any remaining RKE2 or Kubernetes related directories and files
echo "Cleaning up remaining RKE2 and Kubernetes related directories and files..."
sudo rm -rf /var/lib/rancher/rke2
sudo rm -rf /var/lib/kubelet
sudo rm -rf /etc/rancher/rke2
sudo rm -rf /run/k3s
sudo rm -rf /run/flannel
sudo rm -rf /var/lib/cni
sudo rm -rf /var/lib/calico

# Remove kubectl binary
echo "Removing kubectl binary..."
sudo rm -f /usr/local/bin/kubectl

# Remove kubeconfig files
echo "Removing kubeconfig files..."
rm -rf ~/.kube

echo "Kubernetes (RKE2 and kubectl) uninstallation and cleanup completed."
