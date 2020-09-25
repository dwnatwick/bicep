param myName string

resource sayHello 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
  name: 'sayHello'
  kind: 'AzurePowerShell'
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: { }
  }
  location: resourceGroup().location
  properties: {
    arguments: '-name "${myName}"'
    azPowerShellVersion: '3.0'
    scriptContent: 'param([string] $name)\n $DeploymentScriptOutputs = @{text = "Hello $name!";}'
    cleanupPreference: 'OnSuccess'
    retentionInterval: 'P1D'
  }
}

output text string = sayHello.properties.outputs.text