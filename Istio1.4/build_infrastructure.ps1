$resourceGroup = 'IstioExampleResourceGroup'
$clusterName = 'IstioExampleCluster'

# If you don't have Chocllatey, you are welcome:
# Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Install the Azure CLI
# choco install azure-cli

# Login to Azure
az login

# Create resource group and cluster
az group create --name $resourceGroup --location westus
az aks create --resource-group $resourceGroup --name $clusterName --node-count 4 --node-vm-size Standard_B2ms --generate-ssh-keys

# Install Kubernetes CLI (kubectl)
az aks install-cli

# Create local configuration file to talk to the AKS Cluster
az aks get-credentials --resource-group $resourceGroup --name $clusterName

# Assign Kubernetes Dashboard permissions to the cluster
kubectl create clusterrolebinding kubernetes-dashboard --clusterrole=cluster-admin --serviceaccount=kube-system:kubernetes-dashboard

# Display the version of Kubernetes
az aks show --resource-group $resourceGroup --name $clusterName --query kubernetesVersion

#Launch Kubernetes Dashboard
az aks browse --resource-group $resourceGroup --name $clusterName