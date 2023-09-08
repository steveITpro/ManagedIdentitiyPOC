targetScope = 'subscription'

param location string = 'ukwest'
param resourceGroupName string
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
