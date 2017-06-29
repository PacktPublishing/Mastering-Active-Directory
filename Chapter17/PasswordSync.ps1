$adConnector = "<CASE SENSITIVE AD CONNECTOR NAME>" 
$azureadConnector = "<CASE SENSITIVE AZURE AD CONNECTOR NAME>" 
Import-Module “C:\Program Files\Microsoft Azure AD Sync\Bin\ADSync\ADSync.psd1” 
$c = Get-ADSyncConnector -Name $adConnector 
$p = New-Object Microsoft.IdentityManagement.PowerShell.ObjectModel.ConfigurationParameter "Microsoft.Synchronize.ForceFullPasswordSync", String, ConnectorGlobal, $null, $null, $null
$p.Value = 1 
$c.GlobalParameters.Remove($p.Name) 
$c.GlobalParameters.Add($p) 
$c = Add-ADSyncConnector -Connector $c 
Set-ADSyncAADPasswordSyncConfiguration -SourceConnector $adConnector -TargetConnector $azureadConnector -Enable $false 
Set-ADSyncAADPasswordSyncConfiguration -SourceConnector $adConnector -TargetConnector $azureadConnector -Enable $true 