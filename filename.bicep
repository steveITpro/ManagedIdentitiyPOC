param location string = 'ukwest'
param userAssignedIdentities_GCS_ManagedIdentitiy_name string = 'GCS_ManagedIdentitiy'
param resourceGroupName string = 'MyResourceGroup'

var uniqueString = substring(uniqueString(resourceGroupName), 0, 3)

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: '${resourceGroupName}${uniqueString}'
  location: location
}

resource managedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: '${userAssignedIdentities_GCS_ManagedIdentitiy_name}${uniqueString}'
  location: location
}

resource federatedIdentityCredentials 'Microsoft.ManagedIdentity/userAssignedIdentities/federatedIdentityCredentials@2023-01-31' = {
  parent: managedIdentity
  name: 'ManagedIdentitiyPOC${uniqueString}'
  properties: {
    issuer: 'https://token.actions.githubusercontent.com'
    subject: 'repo:steveITpro/ManagedIdentitiyPOC:ref:refs/heads/Main'
    audiences: [
      'api://AzureADTokenExchange'
    ]
  }
}
