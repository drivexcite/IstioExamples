$resourceGroup = 'IstioExampleResourceGroup'
$clusterName = 'IstioExampleCluster'

az group create --name $resourceGroup --location westus
az aks create --resource-group $resourceGroup --name $clusterName --node-count 2 --node-vm-size Standard_B2ms --generate-ssh-keys

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