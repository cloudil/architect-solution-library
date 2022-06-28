## Provision Managed Kubernetes Cluster and Node Group with autoscaling
[Create K8S cluster ](https://cloudil.co.il/docs/managed-kubernetes/quickstart.html)
[Create autoscaling node group](https://cloudil.co.il/docs/managed-kubernetes/operations/autoscale.html#ca)

## CloudIL СLI Installation
To automate CloudIL credentials provisioning (iam-token) install YC-CLI using the following guide [YC CLI](https://cloudil.co.il/docs/cli/quickstart.html)

## Install ALB-INGRESS controller
[Install and configure ALB Ingress controller ](https://cloudil.co.il/docs/managed-kubernetes/tutorials/alb-ingress-controller.html)

## Install ArgoCD
```bash
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
kubectl patch svc argocd-server -n argocd -p '{"spec": {"externalTrafficPolicy": "Local"}}'
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
```
And then connect ArgoCD to your repository or this repostitory

## Provision DNS records and certificates

* [Configure public DNS zone for your application ](https://cloudil.co.il/docs/dns/operations/zone-create-public.html)
* [Reserve static public IP address](https://cloudil.co.il/docs/vpc/operations/get-static-ip.html)
* [Create A-record for your application pointing towards that public ip ](https://cloudil.co.il/docs/dns/operations/zone-create-public.html)
* [Obtain let's encrypt certificate for your application ](https://cloudil.co.il/docs/certificate-manager/operations/managed/cert-create.html)

## change configuration in ALB-ingress specification
```YAML
  annotations:
    ingress.alb.yc.io/subnets: ddkgdejub6sg999mbh2o ### CHANGE THIS subnet list for ALB to accept traffic
    ingress.alb.yc.io/external-ipv4-address: 46.243.yyy.xxx ### CHANGE THIS for external ip address to recieve traffic or use auto to auto
    ingress.alb.yc.io/group-name: default ### default group for ingress resources, reach group will be served by dedicated ALB, while resources in the same group will share the same ALB
    ingress.alb.yc.io/protocol: grpc ### specified that gRPC protocol will be configured for current ingress
spec:
  tls:
    - hosts:
        - grpc.av-cloudarch.site
      secretName: yc-certmgr-cert-id-b25trg5qr3eurt71t6m9 # CHANGE THIS for unique id of cerficicate from CloudIL Certificate Manager
```

And then copy INGRESS.YAML to grpc-autoscaling directory, so argoCD automatically detects change
## Test app
Manually:
```bash
while true; do grpcurl -d '{"x": "21", "y": "12"}' grpc.av-cloudarch.site:443 api.Adder.Add; done
```
Or use attached ammo.json and load.conf to use LOAD-TESTING service (available soon)

Watch your application to autoscale:

```bash
watch kubectl get pod,svc,hpa,nodes -o wide
```
