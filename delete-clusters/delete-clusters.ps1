
$subscriptionId = ""
$resourceGroup = ""
$tenantId = ""

#Using CLI 
$login = az login --tenant $tenantId
az account set -s  $subscriptionId

#Get all clusters in a resource group

$clusterIds = az stack-hci cluster list --resource-group $resourceGroup --query "[].id" -o tsv

#Delete all clusters in a resource group
az stack-hci cluster delete --ids $clusterIds --resource-group $resourceGroup

#delete a particular cluster in a resource group

$clusterName = ""
az stack-hci cluster delete --name $clusterName --resource-group $resourceGroup

#Using Powwershell
Connect-AzAccount -Tenant $tenantId 
Set-AzContext -Subscription $subscriptionId

#Get all clusters in a resource group
$clusters = (Get-AzStackHciCluster -ResourceGroupName $resourceGroup).Name 

#Delete all clusters in a resource group
foreach ($cluster in $clusters) {
    Start-Job -ScriptBlock {
        "Deleting cluster $using:cluster"
        Remove-AzStackHciCluster -Name $using:cluster -ResourceGroupName $using:resourceGroup
    }
}

#delete a particular cluster in a resource group
$clusterName = ""
Remove-AzStackHciCluster -Name $clusterName -ResourceGroupName $resourceGroup


