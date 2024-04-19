# Guide: Accessing and Configuring MinIO UI via SSH Tunneling with Policy Adjustments

## Introduction
Recently had an issue where i was unable to access a website within a kubernetes cluster because the Minio policy for the html file was set to private. This guide provides a detailed method to address access issues to the MinIO UI, particularly when MinIO's policy is set to private. It outlines how to securely access and configure the MinIO UI to change its access policy from private to custom or public, allowing proper handling of resources like `https://vic.local/home/front/index.html`.

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Problem Description](#problem-description)
3. [Ensure MinIO Service Accessibility](#ensure-minio-service-accessibility)
4. [Set Up SSH Tunneling](#set-up-ssh-tunneling)
5. [Access the MinIO UI](#access-the-minio-ui)
6. [Adjusting MinIO Policies](#adjusting-minio-policies)
7. [Conclusion](#conclusion)

## Prerequisites

- Access to a Kubernetes cluster.
- Administrative access to a VM where MinIO is deployed.
- SSH credentials for the remote server and intermediary bastion host.
- MinIO client (`mc`) installed for policy adjustments.

## Problem Description

Access to `https://vic.local/home/front/index.html` was being blocked due to MinIO's bucket policy being set to private, which restricts public access to the stored resources. This necessitated changing the policy to either custom or public to enable proper resource access.

## Ensure MinIO Service Accessibility

Confirm that MinIO is accessible within the VM:

```bash
kubectl get svc minio -n <namespace>
```

Replace `<namespace>` with the actual namespace where MinIO is deployed to confirm the service and port details.

## Set Up SSH Tunneling

Update your SSH configuration to include necessary port forwarding through a bastion host:

```plaintext
Host vic-vm1
  User user
  HostName 192.121.111.23
  ProxyJump vic-bastion
  DynamicForward 2070
  LocalForward 9001 127.0.0.1:9001
```

Connect using the updated SSH configuration:

```bash
ssh vic-vm1
```

## Access the MinIO UI

With the SSH tunnel established, use a web browser to navigate to:

```
http://localhost:9001
```

## Adjusting MinIO Policies

To resolve the access issue, the MinIO bucket policy was changed from private to public using the following commands:

```bash
mc alias set myminio http://localhost:9001 minio minio123
mc policy set public myminio/mybucket
```

Replace `minio` and `minio123` with your actual MinIO access key and secret key. This change allowed unrestricted public access to the resources, resolving the issue with accessing `https://vic.local/home/front/index.html`.

## Conclusion

By following these steps, secure access to the MinIO UI was established via an SSH tunnel, and the bucket policy was successfully adjusted to allow proper handling of web resources, thereby resolving the initial access issue.