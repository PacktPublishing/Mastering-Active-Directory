$username = Read-Host 'What is the User account you looking for ?'
   $dcs = Get-ADDomainController -Filter {Name -like "*"}
      foreach($dc in $dcs)
   { 
     $hostname = $dc.HostName
     $user = Get-ADUser $userName -Server $hostname -Properties lastLogon
     $lngexpires = $user.lastLogon
     if (-not ($lngexpires)) {$lngexpires = 0 }
     If (($lngexpires -eq 0) -or ($lngexpires -gt [DateTime]::MaxValue.Ticks))
     {
       $LastLogon = "User Never Logged In"
     }
      Else
     {
       $Date = [DateTime]$lngexpires
       $LastLogon = $Date.AddYears(1600).ToLocalTime()
     }
  }
  Write-Host $username "last logged on at:" $LastLogon