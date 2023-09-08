param location string
param userAssignedIdentities_GCS_ManagedIdentitiy_name string
param resourceGroupName string

var uniqueSuffix = substring(uniqueString(deployment().name), 0, 3)
var managedIdentityName = '${userAssignedIdentities_GCS_ManagedIdentitiy_name}${uniqueSuffix}'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: '${resourceGroupName}${uniqueSuffix}'
  location: location
}

// Reference to an existing Managed Identity
resource symbolicname 'Microsoft.ManagedIdentity/identities@2023-01-31' existing = {
  name: managedIdentityName
}

resource federatedIdentityCredentials 'Microsoft.ManagedIdentity/userAssignedIdentities/federatedIdentityCredentials@2023-01-31' = {
  parent: symbolicname
  name: 'ManagedIdentitiyPOC${uniqueSuffix}'
  properties: {
    issuer: 'https://token.actions.githubusercontent.com'
    subject: 'repo:steveITpro/ManagedIdentitiyPOC:ref:refs/heads/Main'
    audiences: [
      'api://AzureADTokenExchange'
    ]
  }
}
