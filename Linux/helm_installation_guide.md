
# Helm Installation and Initialization Guide

## Problem

When trying to install and initialize Helm, you may encounter the following issues:

1. **Command Not Found:** After installing Helm, running `helm` commands such as `helm init` results in a "command not found" error.
2. **Permission Denied:** Even after installing Helm, trying to run `helm init` might return a "Permission denied" error.
3. **Unknown Command:** Running `helm init` may fail with an error indicating that "init" is an unknown command.

### Example of the Problem:

```bash
$ helm init
bash: helm: command not found...

$ sudo helm init
bash: /usr/local/bin/helm: Permission denied
```

## Solution

### Step 1: Download and Install Helm

If Helm is not already installed on your system, follow these steps:

1. Download the Helm installation script:

    ```bash
    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
    ```

2. Set executable permissions on the script:

    ```bash
    chmod 700 get_helm.sh
    ```

3. Run the script to install Helm:

    ```bash
    ./get_helm.sh
    ```

    Output:

    ```bash
    Downloading https://get.helm.sh/helm-v3.15.4-linux-amd64.tar.gz
    Verifying checksum... Done.
    Preparing to install helm into /usr/local/bin
    helm installed into /usr/local/bin/helm
    ```

### Step 2: Fix Permissions

After installation, Helm might be installed with restrictive permissions, resulting in a "Permission denied" error when trying to use it. To fix this:

1. Check the current permissions of the Helm binary:

    ```bash
    ls -l /usr/local/bin/helm
    ```

    You may see output similar to this:

    ```bash
    -rwx------. 1 root root 52445336 Aug 22 17:43 /usr/local/bin/helm
    ```

    Notice that the permissions are restrictive (`rwx------`), which means only the `root` user can execute the binary.

2. Change the permissions to allow all users to execute the binary:

    ```bash
    sudo chmod 755 /usr/local/bin/helm
    ```

3. Verify the new permissions:

    ```bash
    ls -l /usr/local/bin/helm
    ```

    Output should now be:

    ```bash
    -rwxr-xr-x. 1 root root 52445336 Aug 22 17:43 /usr/local/bin/helm
    ```

### Step 3: Running Helm Commands

After adjusting the permissions, you should be able to run Helm commands without issues. However, note that in Helm 3, the `init` command has been removed.

1. **Helm Init Alternative:** The `helm init` command was used in Helm 2 to initialize Helm’s server-side component, Tiller. Helm 3 no longer uses Tiller, so the `helm init` command is no longer necessary.

2. To confirm Helm is working, run:

    ```bash
    helm help
    ```

    You should see the usage and available commands for Helm.

### Example Workflow:

```bash
$ helm help

Helm is a tool for managing Charts. Charts are packages of pre-configured Kubernetes resources.

Common actions for Helm:

- helm search:    search for charts
- helm pull:      download a chart to your local directory to inspect or modify
- helm install:   upload the chart to Kubernetes
- helm list:      list releases of charts

...
```

## Summary

1. Download and run the Helm installation script.
2. Set executable permissions on the Helm binary.
3. In Helm 3, the `init` command is no longer available since Helm no longer uses Tiller.
4. Ensure Helm is working properly by running commands like `helm help` or `helm version`.

### Common Errors and Solutions:

- **Command Not Found:** Ensure Helm is installed and the binary is located in a directory that is included in your system's `PATH`.
- **Permission Denied:** Adjust the permissions of the Helm binary to allow execution for all users.
- **Unknown Command "init":** This is expected in Helm 3 since the `init` command has been removed.

With these steps, you should now have Helm correctly installed and operational!
