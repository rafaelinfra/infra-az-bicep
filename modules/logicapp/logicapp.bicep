//************************
//Logic App Template Bicep
//**************************

// ** Parameters **
// ****************

@description('Logic App Name')
param logicAppName string

@description('The location that the resource will be deployed to')
param location string

@description('Trigger Interval')
//param interval string = '1.0.0.0'
param tagsvalue object
param environment string

@description('Nome da identidade gerenciada utilizada pelo logic app')
param identityName string
// param prefix string
// param sufix string

param testUri string = 'https://azure.status.microsoft/status/'

var frequency = 'hour'
var interval = '730'
var type = 'recurrence'
var actionType = 'http'
var method = 'GET'
var workflowSchema = 'https://schema.management.azure.com/providers/Microsoft.Logic/schemas/2016-06-01/workflowdefinition.json#'

var scopeExpression = (environment == 'lab') ? 'rg-xxxx-${environment}' 
                    : (environment == 'hml') ? 'rg-xxxxx-lgpd' 
                    : 'rg-xxxxxx-${environment}'

// ** Resources **
// ***************

// Recurso da identidade gerenciada do usuário atribuído
resource userAssignedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' existing = {
  name: identityName
  scope: resourceGroup(scopeExpression)
}

resource logicAppDeployment 'Microsoft.Logic/workflows@2019-05-01' = {
  name: logicAppName
  location: location 
  tags: tagsvalue 
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${userAssignedIdentity.id}': {}
    }
  }
  properties: {
    state: 'Disabled'
    definition: {
      '$schema': workflowSchema
      contentVersion: '1.0.0.0'
      parameters: {
        testUri: {
          type: 'string'
          defaultValue: testUri
        }
      }
      triggers: {
        recurrence: {
          type: type
          recurrence: {
            frequency: frequency
            interval: interval
          }
        }
      }
      actions: {
        actionType: {
          type: actionType
          inputs: {
            method: method
            uri: testUri
          }
        }
      }
    }
  }
}

// ** Outputs **
// *************

output LogicAppName string = logicAppName
