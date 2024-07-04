param automationName string
param locationDefault string
param tagsvalue object

resource automationaccount 'Microsoft.Automation/automationAccounts@2023-11-01' = {
  name: automationName
  location: locationDefault
  tags: tagsvalue
  identity: {
     type: 'SystemAssigned'
  }
  properties: {    
    sku: {
      name: 'Basic'
    }
  }
}
