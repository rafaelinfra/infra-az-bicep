/************************
Logic App Template Bicep
**************************/

// ** Parameters **
// ****************

@description('Logic App Name')
param logicAppName string

@description('The location that the resource will be deployed to')
param location string

@description('Trigger Interval')
//param interval string = '1.0.0.0'
param tagsvalue object
// param prefix string
// param sufix string

// ** Variables **
// ***************

//var logicAppDefinition = loadTextContent('./defination.json') // Load our definition into a string variable
//var logicAppReplacementParameter = replace(logicAppDefinition, '**interval**', interval) // Replace tokens with our parameters
//var logicAppDefinitionJson = json(logicAppReplacementParameter) // Retrieve the Json object from the Json String so we can access specific data when assigning

var teste1 = loadJsonContent('./defination.json')
//var teste2 = loadJsonContent('./parameters.json')

// ** Resources **
// ***************

resource logicAppDeployment 'Microsoft.Logic/workflows@2019-05-01' = {
  name: logicAppName
  location: location 
  tags: tagsvalue 
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '/subscriptions/xxxxxxxxxxxxxxx/resourcegroups/xxxxxxxxxxxx/providers/Microsoft.ManagedIdentity/userAssignedIdentities/xxxxxxxxxxx': {}
    }
  }
  properties: {
    state: 'Disabled'
    definition: teste1.definition // Set the definition
    parameters: teste1.parameters // Set any Properties that may be set
  }
}

// ** Outputs **
// *************

output LogicAppName string = logicAppName
