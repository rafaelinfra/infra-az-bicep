//targetScope = 'resourceGroup'


param storageName string
@description('localização padrão')
param locationDefault string
param tagsvalue object
@allowed([
'Standard_LRS'
'Standard_GRS'
'Standard_ZRS'
])
param storageSKU string = 'Standard_LRS'
@allowed([
  'xxxxxxxxxxxxxxxxxxxx'
  'data'
  ])
param containerName string

resource stgdefault 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageName
  location: locationDefault
  tags: tagsvalue
  sku: {
    name: storageSKU
  }
  kind: 'StorageV2'
  properties: {
    
    supportsHttpsTrafficOnly: true
    accessTier: 'Hot'
    isHnsEnabled: true
    minimumTlsVersion: 'TLS1_2'
    keyPolicy: {
      keyExpirationPeriodInDays: 60
    }
    networkAcls: {
      defaultAction: 'Allow'
    }
  }
}

resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2023-01-01' = {
  parent: stgdefault
  name: 'default'
}

resource blobContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-01-01' = {
  parent: blobService
  name: containerName
}

output storageEndpoint object = stgdefault.properties.primaryEndpoints
