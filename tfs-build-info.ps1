#Author: Kelsey Hilton
#Last updated: 1/13/2018
##Powershell Script to find the status of the previous builds and store pertinent data in the database
Param(
[string] $TFSuri = $(Read-Host -prmpt "What's the TFS URI? Example: http://tfs:8080/tfs")
)
$tfsConfigurationServer = [Microsoft.TeamFoundation.Client.TfsConfigurationServerFactory]::GetConfigurationServer($TFSuri)
$tpcService = $tfsConfigurationServer.GetService("Microsoft.TeamFoundation.Framework.Client.ITeamProjectCollectionService")
 

function Import-TFSAssembly{
  Add-Type -AssemblyName 
  "Microsoft.TeamFoundation.Common, Version=11.0.0.0,Cutlure=neutral, Publi KeyToken=b03f5f711d50a3a",
  "Microsoft.TeamFoundation, Version=11.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
  Add-Type -AssemblyName "Microsoft.TeamFoundation.Client, Version=12.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
}

$TFS = [Microsoft.TeamFoundation.Client.TfsTeamProjectCollectionFactory]::GetTeamProjectCollection($TFSuri)
$TFS.EnsureAuthenticated()
if(!TFS.HasAuthenticated){
  Write-Host "Not authenticated. Exiting."
  exit
}
else{
  Write-Host "Successfully authenticated"
}

$sortedCollections = $tpcService.GetCollections() | Sort-Object -Property Name
 
foreach($collection in $sortedCollections) {
    Write-Host $collection.Name
}
