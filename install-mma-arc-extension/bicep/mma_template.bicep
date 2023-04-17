var clusterNames = ['cluster1', 'cluster2']


resource clusterNames_name_default_MicrosoftMonitoringAgent 'Microsoft.AzureStackHCI/clusters/arcSettings/extensions@2022-12-01' = [for item in clusterNames: {
  name: '${item}/default/MicrosoftMonitoringAgent'
  properties: {
    extensionParameters: {
      publisher: 'Microsoft.EnterpriseCloud.Monitoring'
      type: 'MicrosoftMonitoringAgent'
      typeHandlerVersion: '1.0.18067.0'
      autoUpgradeMinorVersion: false
      enableAutomaticUpgrade: true
      settings: {
        workspaceId: ''
      }
      protectedSettings: {
        workspaceKey: ''
      }
    }
  }
}]