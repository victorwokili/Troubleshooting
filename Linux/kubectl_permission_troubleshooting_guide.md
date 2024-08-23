
# Resolving `kubectl Permission Denied` Issue on RKE2 Kubernetes Cluster

## Overview

This guide covers the steps and solutions to resolve the issue of running `kubectl` commands on an RKE2 Kubernetes cluster without requiring `sudo`. The primary focus is on permission errors related to the `kubectl` binary and kubeconfig file.

## Problem

### Issue 1: `kubectl: Permission denied`

When trying to execute `kubectl` commands, the following error was encountered:

```bash
$ kubectl get nodes
bash: /usr/bin/kubectl: Permission denied
```

### Issue 2: Missing `.kube/config` Directory

After attempting to change permissions of the `~/.kube/config` file, the following error was encountered:

```bash
$ sudo chown ($INPUTUSERNAME):($INPUTUSERNAME) ~/.kube/config
chown: cannot access '/home/($INPUTUSERNAME)/.kube/config': No such file or directory
```

## Solution

### Step 1: Adjust Permissions for `kubectl`

The `kubectl` binary located at `/usr/bin/kubectl` had restrictive permissions, which only allowed the root user to execute it. To fix this:

1. Check the permissions of the `kubectl` binary:
    ```bash
    ls -l /usr/bin/kubectl
    ```

2. Modify the permissions to allow execution by all users:
    ```bash
    sudo chmod 755 /usr/bin/kubectl
    ```

This will allow any user on the system to execute the `kubectl` binary without needing `sudo`.

### Step 2: Ensure the `.kube` Directory Exists

Since the `.kube` directory was missing, it needed to be created. Follow these steps to set up the directory and ensure correct permissions:

1. Create the `.kube` directory in your home directory:
    ```bash
    mkdir -p ~/.kube
    ```

2. Copy the `rke2.yaml` kubeconfig file from the RKE2 directory:
    ```bash
    sudo cp /etc/rancher/rke2/rke2.yaml ~/.kube/config
    ```

3. Change the ownership of the kubeconfig file to your user:
    ```bash
    sudo chown ($INPUTUSERNAME):($INPUTUSERNAME) ~/.kube/config
    ```

This ensures that your user owns the kubeconfig file and can access it without `sudo`.

### Step 3: Update Kubeconfig Server URL (if necessary)

If the server URL in the kubeconfig file needs to be updated, you can edit the file:

1. Open the kubeconfig file for editing:
    ```bash
    nano ~/.kube/config
    ```

2. Ensure the `server:` field points to the correct API server address, which is typically:
    ```yaml
    server: https://127.0.0.1:6443
    ```

3. Save and exit the file.

### Step 4: Verify the Setup

After setting up the correct permissions and kubeconfig, verify that `kubectl` works without `sudo`:

```bash
kubectl get nodes
```

If everything is set up correctly, you should see the nodes in your cluster listed without any permission errors.

### Example Output:

```bash
$ kubectl get nodes
NAME          STATUS   ROLES                       AGE     VERSION
cluster-name   Ready    control-plane,etcd,master   3h37m   v1.30.1+rke2r1
```

## Conclusion

By following these steps, you can ensure that `kubectl` commands can be executed without `sudo`, and the kubeconfig file is properly configured for your user. This avoids the common permission issues encountered when working with Kubernetes on RKE2.

### Lessons Learned:
- Always ensure proper permissions on executables like `kubectl`.
- Make sure the `.kube/config` directory is correctly set up and owned by the appropriate user.
- Avoid using `sudo` for everyday Kubernetes commands by ensuring user permissions are configured correctly from the start.

With this guide, you can confidently resolve permission-related issues for `kubectl` on RKE2 Kubernetes clusters.
