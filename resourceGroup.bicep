param location string = 'ukwest'
param managedIdentityName string = 'GCS_ManagedIdentity'

resource managedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: managedIdentityName
  location: location
}

resource federatedCredentials 'Microsoft.ManagedIdentity/userAssignedIdentities/federatedIdentityCredentials@2023-01-31' = {
  name: '${managedIdentityName}/ManagedIdentitiyPOC'
  properties: {
    issuer: 'https://token.actions.githubusercontent.com',
    subject: 'repo:steveITpro/ManagedIdentitiyPOC:ref:refs/heads/Main',
    audiences: ['api://AzureADTokenExchange']
  }
  dependsOn: [managedIdentity]
}
