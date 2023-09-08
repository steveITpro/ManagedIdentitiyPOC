name: Run Azure Login with OpenID Connect
on: [push]

permissions:
  id-token: write
  contents: read

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest

    steps:
    - name: 'Checkout code'
      uses: actions/checkout@v2

    - name: 'Az CLI login'
      uses: azure/login@v1
      with:
          client-id: ${{ secrets.AZURE_CLIENT_ID }}
          tenant-id: ${{ secrets.AZURE_TENANT_ID }}
          subscription-id: ${{ secrets.AZURE_SUBSCRIPTION_ID }}

    - name: Deploy ARM template
      run: |
        az deployment sub create --location ukwest --template-file path_to_arm_template.json