## Script For Filter user with Last logon Time ##
$htmlformat = "<style>BODY{background-color:LightBlue;}</style>"
Get-ADUser -Filter * -Properties “LastLogonDate” | sort-object -property lastlogondate -descending | Select-Object Name,LastLogonDate | ConvertTo-HTML -head $htmlformat -body "<H2>AD Accounts Last Login Date</H2>"| Out-File C:\lastlogon.html
Invoke-Expression C:\lastlogon.html