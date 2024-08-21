
# Comprehensive Guide to Fixing SSL Self-Signed Certificate Issue on RHEL

This guide walks you through resolving the error when trying to clone a Git repository from a self-hosted GitLab instance with a self-signed certificate. This is particularly for RHEL-based systems. 

### Problem:

When trying to clone the repository:

```bash
git clone https://VICTILI:UNmHzGkW@gitlab.elbrfgil/helm-parent-chart.git
```

You encounter the following error:

```
Cloning into 'helm-parent-chart'...
fatal: unable to access 'https://gitlab.elbrfgil/helm-parent-chart.git/': SSL certificate problem: self-signed certificate in certificate chain
```

### Solution Overview:

The error occurs due to the self-signed SSL certificate in the certificate chain used by the GitLab server. To fix this, we will:

1. Retrieve the SSL certificate from the GitLab server.
2. Install the certificate into the trusted certificates store.
3. Update the system's certificate authority.

---

### Step 1: Retrieve the SSL Certificate

Use `openssl` to retrieve the SSL certificates from the GitLab server. This command fetches the certificate chain:

```bash
sudo openssl s_client -showcerts -verify 5 -connect gitlab.elbrfgil:443 < /dev/null | awk '/BEGIN/,/END/{ if(/BEGIN/){a++}; out="cert"a".pem"; print >out}'
```

#### Common Issue:
You might encounter the following error when running the command:
```
awk: cmd. line:1: (FILENAME=- FNR=8) fatal: cannot redirect to `cert1.pem': Permission denied
```

This happens due to a permission issue when writing the certificate files.

---

### Step 2: Fixing Permission Issues

You need to ensure that you have the proper write permissions in the directory where you are executing the `openssl` command. There are two ways to fix this:

1. **Option 1**: Temporarily change the directory permissions.
```bash
cd /usr/share/pki/ca-trust-source/
sudo chmod u+w anchors
```

2. **Option 2**: Change ownership of the directory to your user temporarily.
```bash
cd /usr/share/pki/ca-trust-source/
sudo chown nimdadod:nimdadod anchors
```

You can then rerun the command to retrieve the certificates:
```bash
sudo openssl s_client -showcerts -verify 5 -connect gitlab.elbrfgil:443 < /dev/null | awk '/BEGIN/,/END/{ if(/BEGIN/){a++}; out="cert"a".pem"; print >out}'
```

This should save the certificates to files such as `cert1.pem`, `cert2.pem`, etc.

---

### Step 3: Installing the Certificate

Once you have the certificate files, install them into the system's trusted certificate store:

1. Copy the certificate(s) to the trusted anchors directory:
```bash
sudo cp cert1.pem /usr/share/pki/ca-trust-source/anchors/
```

2. Update the trusted certificates:
```bash
sudo update-ca-trust
```

---

### Step 4: Verify the Fix

Now, try to clone the repository again:

```bash
git clone https://VICTILI:UNmHzGkW@gitlab.elbrfgil/helm-parent-chart.git
```

If the issue was successfully resolved, the clone should proceed without SSL certificate errors.

---

### Additional Notes:

- If the problem persists, ensure that all certificates in the chain have been correctly installed. You might need to repeat the process for each certificate in the chain.
- RHEL uses the `update-ca-trust` command to manage certificate authorities. Ensure that you are working with the right directories (`/usr/share/pki/ca-trust-source/anchors/`) when adding certificates.
