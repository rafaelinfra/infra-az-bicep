param factoryName string
param locationDefault string
param tagsvalue object

resource DataFactory 'Microsoft.DataFactory/factories@2018-06-01' = {
  name: factoryName
  location: locationDefault
  identity: {
    type: 'SystemAssigned'
  }
  
  properties: {
     repoConfiguration: {
      accountName: 'xxxxxxxxx'
      collaborationBranch: 'main'
      projectName: 'xxxxxx'
      repositoryName: 'xxxxxxx'
      rootFolder: '/datafactory'
      type: 'FactoryVSTSConfiguration'
     }
  }
  tags: tagsvalue
}
