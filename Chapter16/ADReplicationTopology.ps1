## Script to gather information about Replication Topology ##
## Define Objects ##
$replreport = New-Object PSObject -Property @{
Domain = $null
}
## Find Domain Information ##
$replreport.Domain = (Get-ADDomain).DNSroot
## List down the AD sites in the Domain ##
$a = (Get-ADReplicationSite -Filter *)
Write-Host "########" $replreport.Domain "Domain AD Sites" "########"
$a | Format-Table Description,Name -AutoSize
## List down Replication Site link Information ##
$b = (Get-ADReplicationSiteLink -Filter *)
Write-Host "########" $replreport.Domain "Domain AD Replication SiteLink Information" "########"
$b | Format-Table Name,Cost,ReplicationFrequencyInMinutes -AutoSize
## List down SiteLink Bridge Information ##
$c = (Get-ADReplicationSiteLinkBridge -Filter *)
Write-Host "########" $replreport.Domain "Domain AD SiteLink Bridge Information" "########"
$c | select Name,SiteLinksIncluded | Format-List
## List down Subnet Information ##
$d = (Get-ADReplicationSubnet -Filter * | select Name,Site)
Write-Host "########" $replreport.Domain "Domain Subnet Information" "########"
$d | Format-Table Name,Site -AutoSize
## List down Prefered BridgeHead Servers ##
$e = ([adsi]"LDAP://CN=IP,CN=Inter-Site Transports,CN=Sites,CN=Configuration,DC=rebeladmin,DC=com").bridgeheadServerListBL
Write-Host "########" $replreport.Domain "Domain Prefered BridgeHead Servers" "########"
$e
## End of the Script ##