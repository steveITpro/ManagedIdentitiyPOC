param location string
param userAssignedIdentities_GCS_ManagedIdentitiy_name string
param resourceGroupName string

var uniqueSuffix = substring(uniqueString(deployment().name), 0, 3)

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: '${resourceGroupName}${uniqueSuffix}'
  location: location
}

// Specify existing resource group context for managed identity
resource existingRg 'Microsoft.Resources/resourceGroups@2021-04-01' existing = {
  name: rg.name
}

resource managedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: '${userAssignedIdentities_GCS_ManagedIdentitiy_name}${uniqueSuffix}'
  location: location
  scope: existingRg
}

resource federatedIdentityCredentials 'Microsoft.ManagedIdentity/userAssignedIdentities/federatedIdentityCredentials@2023-01-31' = {
  parent: managedIdentity
  name: 'ManagedIdentitiyPOC${uniqueSuffix}'
  properties: {
    issuer: 'https://token.actions.githubusercontent.com'
    subject: 'repo:steveITpro/ManagedIdentitiyPOC:ref:refs/heads/Main'
    audiences: [
      'api://AzureADTokenExchange'
    ]
  }
}
