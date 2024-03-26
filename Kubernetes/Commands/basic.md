```bash
kubectl create secret generic my-config --from-file=path/to/myfile.conf
```

```bash
kubectl get pod beebox-shipping-data -o yaml > beebox-shipping-data.yml
```

```bash
kubectl exec busybox -- curl xxx.xxx.xxx.x:8080
```
