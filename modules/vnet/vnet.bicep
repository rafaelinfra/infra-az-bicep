@description('VNet name')
param vnetName string

@description('Address prefix')
param vnetAddressPrefix string

@description('Subnet 1 Prefix')
param subnet1Prefix string

@description('Subnet 1 Name')
param subnet1Name string

@description('Subnet 2 Prefix')
param subnet2Prefix string

@description('Subnet 2 Name')
param subnet2Name string

@description('Location for all resources.')
param location string

@description('Location for all resources.')
param tagsvalue object


// param nsg string

resource vnet 'Microsoft.Network/virtualNetworks@2021-08-01' = {
  name: vnetName
  location: location
  tags: tagsvalue
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetAddressPrefix
      ]
    }
    subnets: [
      {
        name: subnet1Name
        properties: {
          addressPrefix: subnet1Prefix
          // networkSecurityGroup: {
          //   id: nsg
          // }
          // delegations: [
          //   {
          //     name: 'databricks-del-private'
          //     properties: {
          //       serviceName: 'Microsoft.Databricks/workspaces'
          //     }
          //   }
          // ]
        }
      }
      {
        name: subnet2Name
        properties: {
          addressPrefix: subnet2Prefix
          // networkSecurityGroup: {
          //   id: nsg
          // }
          // delegations: [
          //   {
          //     name: 'databricks-del-public'
          //     properties: {
          //       serviceName: 'Microsoft.Databricks/workspaces'
          //     }
          //   }
          // ]
        }
      }
    ]
  }
}

output vnetid string = vnet.id
