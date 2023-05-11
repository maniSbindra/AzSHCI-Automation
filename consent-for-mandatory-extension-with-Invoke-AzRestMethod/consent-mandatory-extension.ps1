$subscriptionId = ""
$resourceGroup = ""
$tenantId = ""

Connect-AzAccount -Subscription $subscriptionId -Tenant $tenantId

$clusters = Get-AzResource -ResourceGroupName $resourceGroup -ResourceType "Microsoft.AzureStackHCI/clusters" | Select-Object -ExpandProperty ResourceId

foreach ($cluster in $clusters) {
    $path = "$cluster/arcSettings/default/consentAndInstallDefaultExtensions?api-version=2023-03-01"

    Write-Host ("Consenting for mandatory extensions on cluster $cluster")

    Invoke-AzRestMethod `
        -Path $path `
        -Method POST `
        -AsJob
}

