param userAssignedIdentities_GCS_ManagedIdentitiy_name string = 'GCS_ManagedIdentitiy'

resource managedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: userAssignedIdentities_GCS_ManagedIdentitiy_name
  location: 'ukwest'
}

resource federatedIdentityCredentials 'Microsoft.ManagedIdentity/userAssignedIdentities/federatedIdentityCredentials@2023-01-31' = {
  name: '${managedIdentity.name}/ManagedIdentitiyPOC'
  properties: {
    issuer: 'https://token.actions.githubusercontent.com'
    subject: 'repo:steveITpro/ManagedIdentitiyPOC:ref:refs/heads/Main'
    audiences: [
      'api://AzureADTokenExchange'
    ]
  }
  dependsOn: [
    managedIdentity
  ]
}
