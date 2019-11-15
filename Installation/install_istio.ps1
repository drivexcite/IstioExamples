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
helm template --name istio --namespace istio-system --set grafana.enabled=True --set kiali.enabled=True --set kiali.dashboard.username=admin --set values.global.disablePolicyChecks=false --set kiali.dashboard.passphrase=admin --set galley.enabled=True .\istio-1.3.4\istio\ > .\01.istio.yaml