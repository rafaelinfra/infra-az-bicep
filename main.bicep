targetScope = 'subscription'
//targetScope = 'resourceGroup'

//************************
//Parameters Default
//**************************

param locationDefault string
param nameDefault string
param environment string
param tagsvalue object

//************************
//Resources Existing
//**************************

resource rg_rafael_blue 'Microsoft.Resources/resourceGroups@2023-07-01' existing = {
  name: 'rg-rafael'
}

//************************
//Resource 
//**************************

module newdtb 'modules/databricks/databricks.bicep' = {
  scope: rg_rafael_blue
  name: 'novodeploy'
  params: {
    bricksName: 'adb-${nameDefault}-${environment}'
    locationDefault: locationDefault
    tagsvalue: tagsvalue
  }
}

module stgdtb 'modules/storageaccount/storage.bicep' = {
  scope: rg_rafael_blue
  name: 'deploystoragedtb'
  params: {
    containerName: 'data'
    locationDefault: locationDefault
    storageName: 'stgadbunity'
    tagsvalue: tagsvalue
  }
}

//@description('Specifies the role definition ID used in the role assignment.')
//param roleDefinitionID string = 'ba92f5b4-2d11-453d-a403-e96b0029c9fe'

// var roleAssignmentName = 'Storage Blob Data Contributor'
// resource roleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
//   name: roleAssignmentName
//   properties: {
//     roleDefinitionId: '/providers/Microsoft.Authorization/roleDefinitions/ba92f5b4-2d11-453d-a403-e96b0029c9fe'
//     principalId: newdtb.outputs.conId
//   }
// }
