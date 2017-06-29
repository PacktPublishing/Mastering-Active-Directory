## Password Expire Report ##
$passwordreport = $null
$dc = (Get-ADDomain | Select DNSRoot).DNSRoot
$Report= "C:\passwordreport.html"
$HTML=@"
<title>Password Expire Report For $dc</title>
<style>
BODY{background-color :LightBlue}
</style>
"@
$passwordreport = Get-ADUser -filter * –Properties "SamAccountName","pwdLastSet","msDS-UserPasswordExpiryTimeComputed" | Select-Object -Property "SamAccountName",@{Name="Last Password Change";Expression={[datetime]::FromFileTime($_."pwdLastSet")}},@{Name="Next Password Change";Expression={[datetime]::FromFileTime($_."msDS-UserPasswordExpiryTimeComputed")}}
$passwordreport | ConvertTo-Html -Property "SamAccountName","Last Password Change","Next Password Change"-head $HTML -body "<H2>Password Expire Report For $dc</H2>"|
Out-File $Report
Invoke-Expression C:\passwordreport.html