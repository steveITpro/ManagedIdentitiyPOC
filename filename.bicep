targetScope = 'subscription'

param location string
param userAssignedIdentities_GCS_ManagedIdentitiy_name string
param resourceGroupName string
param tags object = {
  tagName1: 'tagValue1'
  tagName2: 'tagValue2'
}

var uniqueSuffix = substring(uniqueString(deployment().name), 0, 3)
var managedIdentityName = '${userAssignedIdentities_GCS_ManagedIdentitiy_name}${uniqueSuffix}'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: '${resourceGroupName}${uniqueSuffix}'
  location: location
}

resource newManagedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: managedIdentityName
  location: location
  tags: tags
  scope: resourceGroup(rg.name)
}

resource federatedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities/federatedIdentityCredentials@2023-01-31' = {
  name: 'ManagedIdentitiyPOC${uniqueSuffix}'
  parent: newManagedIdentity
  properties: {
    issuer: 'https://token.actions.githubusercontent.com'
    subject: 'repo:steveITpro/ManagedIdentitiyPOC:ref:refs/heads/Main'
    audiences: [
      'api://AzureADTokenExchange'
    ]
  }
  scope: resourceGroup(rg.name)
}
