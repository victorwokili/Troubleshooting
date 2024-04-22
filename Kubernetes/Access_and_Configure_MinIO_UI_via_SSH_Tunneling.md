# Guide: Accessing and Configuring MinIO UI via SSH Tunneling with Policy Adjustments

## Introduction
This document addresses the challenge of accessing the MinIO UI on a Kubernetes VM behind a bastion host, specifically when faced with network restrictions or strict security policies. It outlines how to securely access and configure the MinIO UI to change its access policy from private to custom or public, thereby allowing proper handling of resources like `https://vic.local/home/front/index.html`.

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Problem Description](#problem-description)
3. [Kubernetes Port Forwarding](#kubernetes-port-forwarding)
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

## Kubernetes Port Forwarding

Before establishing an SSH tunnel, it is necessary to set up port forwarding for the MinIO service within Kubernetes. This allows the MinIO service, typically running on a cluster-internal IP, to be accessible on an exposed port on the host VM:

```bash
kubectl port-forward svc/minio 9001:9001 -n <namespace>
```

Replace `<namespace>` with the actual namespace where MinIO is deployed. This command forwards traffic from port `9001` on your local machine to port `9001` on the MinIO service.

## Set Up SSH Tunneling

Update your SSH configuration to include necessary port forwarding through a bastion host:

```plaintext
Host vic-vm1
  User user
  HostName 194.328.111.87
  ProxyJump vic-bastion
  DynamicForward 2080
  LocalForward 9001 197.0.0.1:9001
```


or you can SSSH tunnel from your terminal ass
```bash
ssh vic-vm1 -L 9001:127.0.0.1:9001
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