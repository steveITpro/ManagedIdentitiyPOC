param location string
param userAssignedIdentities_GCS_ManagedIdentitiy_name string
param resourceGroupName string

var uniqueSuffix = substring(uniqueString(deployment().name), 0, 3)
var managedIdentityName = '${userAssignedIdentities_GCS_ManagedIdentitiy_name}${uniqueSuffix}'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: '${resourceGroupName}${uniqueSuffix}'
  location: location
}

// Managed Identity resources
resource msi 'Microsoft.ManagedIdentity/userAssignedIdentities@2018-11-30' = {
  name: managedIdentityName
  location: location
}

resource federatedIdentityCredentials 'Microsoft.ManagedIdentity/userAssignedIdentities/federatedIdentityCredentials@2023-01-31' = {
  parent: msi
  name: 'ManagedIdentitiyPOC${uniqueSuffix}'
  properties: {
    issuer: 'https://token.actions.githubusercontent.com'
    subject: 'repo:steveITpro/ManagedIdentitiyPOC:ref:refs/heads/Main'
    audiences: [
      'api://AzureADTokenExchange'
    ]
  }
}
