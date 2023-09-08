param location string = 'ukwest'
param managedIdentityName string = 'GCS_ManagedIdentity'
param tags object = {
  tagName1: 'tagValue1',
  tagName2: 'tagValue2'
}

var uniqueSuffix = substring(uniqueString(deployment().name), 0, 3)

resource managedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: '${managedIdentityName}${uniqueSuffix}'
  location: location
  tags: tags
}
