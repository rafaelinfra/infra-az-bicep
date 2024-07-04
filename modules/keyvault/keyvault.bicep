param keyvaultName string
param locationDefault string
param tagsvalue object

resource keyvault 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: keyvaultName
  location: locationDefault
  tags: tagsvalue 
  properties: {
    enableSoftDelete: true
    softDeleteRetentionInDays: 7
    enableRbacAuthorization: false
    sku: {
      family:  'A'
      name:  'standard'
    }
    tenantId: tenant().tenantId
  }
}
