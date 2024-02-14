# Storing secrets in Helm Charts 



``` bash
arch
```



``` bash
curl -LO https://github.com/getsops/sops/releases/download/v3.8.1/sops-3.8.1.x86_64.rpm
```

``` bash
sudo mv sops-3.8.1.x86_64.rpm /usr/local/bin/sops
``` 


``` bash
chmod +x /usr/local/bin/sops
``` 

``` bash
helm plugin install https://github.com/jkroepke/helm-secrets --version v4.5.1
```

``` bash
sudo yum install gunpg
```


helm secrets init --provider=sops
