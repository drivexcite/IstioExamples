$resourceGroup = 'IstioExampleResourceGroup'
$containerRegistry = 'IstioExampleContainerRegistry'
$clusterName = 'IstioExampleCluster'

az group create --name $resourceGroup --location westus
az acr create --resource-group $resourceGroup --name $containerRegistry --admin-enabled --sku Basic 
az configure --defaults acr=$containerRegistry
az aks create --resource-group $resourceGroup --name $clusterName --node-count 2 --node-vm-size Standard_B2ms --generate-ssh-keys

# Install Kubernetes CLI (kubectl)
az aks install-cli

# Create local configuration file to talk to the AKS Cluster
az aks get-credentials --resource-group $resourceGroup --name $clusterName

# Assign Kubernetes Dashboard permissions to the cluster
kubectl create clusterrolebinding kubernetes-dashboard --clusterrole=cluster-admin --serviceaccount=kube-system:kubernetes-dashboard

# Attach the ACR Instance to the Cluster
$containerRegistryId = az acr show --query "id"
az aks update --resource-group $resourceGroup --name $clusterName --attach-acr $containerRegistryId

# The metrics service is automatically installed in Kubnernetes 1.10 and above
az aks show --resource-group $resourceGroup --name $clusterName --query kubernetesVersion

#Launch Kubernetes Dashboard
az aks browse --resource-group $resourceGroup --name $clusterName