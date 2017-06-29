## Report for DC login Faliures ##
$failedevent = $null
$Date= Get-date 
$dc = Read-Host 'What is the Domain Controller ?'
$Report= "C:\auditreport.html"
$HTML=@"
<title>Failed Login Report for $dc</title>
<style>
BODY{background-color :LightBlue}
</style>
"@
 $failedevent = Get-Eventlog security -Computer $dc -InstanceId 4625 -After (Get-Date).AddDays(-7) |
 Select TimeGenerated,ReplacementStrings |
 % {
 New-Object PSObject -Property @{
 SourceComputer = $_.ReplacementStrings[13]
 UserName = $_.ReplacementStrings[5]
 SourceIPAddress = $_.ReplacementStrings[19]
 Date = $_.TimeGenerated
 }
 }
 $failedevent | ConvertTo-Html -Property SourceComputer,UserName,SourceIPAddress,Date -head $HTML -body "<H2>Failed Login Report for $dc</H2>"|
 Out-File $Report
 Invoke-Expression C:\auditreport.html