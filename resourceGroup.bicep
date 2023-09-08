param location string = 'ukwest'
param managedIdentityName string = 'GCS_ManagedIdentity'

var uniqueSuffix = substring(uniqueString(deployment().name), 0, 3)
var federatedCredentialName = managedIdentityName + uniqueSuffix + '/ManagedIdentitiyPOC'

resource managedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: managedIdentityName + uniqueSuffix
  location: location
}

resource federatedCredentials 'Microsoft.ManagedIdentity/userAssignedIdentities/federatedIdentityCredentials@2023-01-31' = {
  name: federatedCredentialName
  properties: {
    issuer: 'https://token.actions.githubusercontent.com',
    subject: 'repo:steveITpro/ManagedIdentitiyPOC:ref:refs/heads/Main',
    audiences: ['api://AzureADTokenExchange']
  }
  dependsOn: [
    managedIdentity
  ]
}
