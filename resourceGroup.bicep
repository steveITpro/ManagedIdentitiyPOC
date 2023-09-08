targetScope = 'subscription'

param location string = 'ukwest'
param resourceGroupName string
param managedIdentityName string = 'GCS_ManagedIdentity'
param tags object = {
  tagName1: 'tagValue1'
  tagName2: 'tagValue2'
}

var uniqueSuffix = substring(uniqueString(deployment().name), 0, 3)

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: '${resourceGroupName}${uniqueSuffix}'
  location: location
  tags: tags
}

resource managedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: '${managedIdentityName}${uniqueSuffix}'
  location: location
  tags: tags
}
