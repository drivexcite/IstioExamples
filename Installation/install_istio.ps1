# Add Istio Repo to Helm
helm repo add istio.io https://storage.googleapis.com/istio-release/releases/1.3.4/charts/

# Create namespace for Istio components
kubectl create namespace istio-system

# Locally fetch the Istio CRDs
helm fetch istio.io/istio-init

#Unzip and extract files from Istio's Helm Template
.\Unzip-Tgz.ps1 .\istio-init-1.3.4.tgz
.\Expand-Tar.ps1 .\istio-init-1.3.4.tar

# Create Istio CRDs YAML for Kubernetes
helm template --name istio-io .\istio-init-1.3.4\istio-init\ > .\00.istio-crd.yaml

# Locally fetch the Istio distribution
helm fetch istio.io/istio

#Unzip and extract files from Istio's Helm Template
.\Unzip-Tgz.ps1 .\istio-1.3.4.tgz
.\Expand-Tar.ps1 .\istio-1.3.4.tar

# Create Istio System YAML for Kubernetes
helm template --name istio --namespace istio-system --set grafana.enabled=True --set kiali.enabled=True --set values.global.disablePolicyChecks=false --set galley.enabled=True .\istio-1.3.4\istio\ > .\01.istio.yaml

# Label default namespace so that resources deployed in it get Envoy proxies automatically injected
kubectl label namespace default istio-injection=enabled

# Alternatively check the namespace definition to verify is correct
# kubectl get namespace default -o yaml

# Installing the bookinfo example
kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yaml
kubectl apply -f samples/bookinfo/networking/bookinfo-gateway.yaml

# To figure out the external IP
kubectl get svc istio-ingressgateway -n istio-system

# Set the default version for all services to v1
kubectl apply -f samples/bookinfo/networking/virtual-service-all-v1.yaml

# Inspect the topology of the service mesh in Kiali
kubectl port-forward kiali-7dd44f7696-hsfql 20001:20001 -namespace istio-system

