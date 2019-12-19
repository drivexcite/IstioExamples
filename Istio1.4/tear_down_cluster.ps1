$resourceGroup = 'IstioExampleResourceGroup'
$clusterName = 'IstioExampleCluster'

az aks delete --resource-group $resourceGroup --name $clusterName