cls
$Prog = DateTime.now
Remove-PSSession $RemoteComputers
$password = ConvertTo-SecureString "XXXXXX" -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential ("FFM\pwainc", $password)
$File = get-content "C:\Data\CCM-PSComputers.txt"
foreach ($line in $File){
$RemoteComputers = $Line
$Prog = $Prog+$RemoteComputers
$Prog = $Prog + " OK `n " 
 #} For testing Loop
$scriptBlock = { C:\windows\ccmsetup\ccmsetup.exe /uninstall }
$scriptBlock1 = { C:\BBWin\bin\BBwin -remove}
New-PSSession  -Credential $Cred -ComputerName $RemoteComputers -debug
$s= Get-PSSession
Enter-PSSession -ComputerName $RemoteComputers
Get-Service -Name CcmExec -ErrorAction SilentlyContinue | Stop-Service -Force -Verbose
Remove-Item -Path "$($Env:WinDir)\CCM\SystemTemp" -Force -Recurse -Confirm:$false -Verbose
Remove-Item -Path "$($Env:WinDir)\CCM\1033" -Force -Recurse -Confirm:$false -Verbose
Remove-Item -Path "$($Env:WinDir)\CCM\CIAgent" -Force -Recurse -Confirm:$false -Verbosetem -Path "$($Env:WinDir)\CCM\SystemTemp" -Force -Recurse -Confirm:$false -Verbose
Remove-Item -Path "$($Env:WinDir)\CCM\CIDownloader" -Force -Recurse -Confirm:$false -Verbose
Remove-Item -Path "$($Env:WinDir)\CCM\ClientUX" -Force -Recurse -Confirm:$false -Verbose
Remove-Item -Path "$($Env:WinDir)\CCM\DeviceGuard" -Force -Recurse -Confirm:$false -Verbose
Remove-Item -Path "$($Env:WinDir)\CCM\Inventory" -Force -Recurse -Confirm:$false -Verbose
Remove-Item -Path "$($Env:WinDir)\CCM\Logs" -Force -Recurse -Confirm:$false -Verbose
Remove-Item -Path "$($Env:WinDir)\CCM\Metering" -Force -Recurse -Confirm:$false -Verbose
Remove-Item -Path "$($Env:WinDir)\CCM\Perf" -Force -Recurse -Confirm:$false -Verbose
Remove-Item -Path "$($Env:WinDir)\CCM\RemCtrl" -Force -Recurse -Confirm:$false -Verbose
Remove-Item -Path "$($Env:WinDir)\CCM\ScriptStore" -Force -Recurse -Confirm:$false -Verbose
Remove-Item -Path "$($Env:WinDir)\CCM\ServiceData" -Force -Recurse -Confirm:$false -Verbose
Remove-Item -Path "$($Env:WinDir)\CCM\SettingsPlugins" -Force -Recurse -Confirm:$false -Verbose
Remove-Item -Path "$($Env:WinDir)\CCM\SignedScripts" -Force -Recurse -Confirm:$false -Verbose
Remove-Item -Path "$($Env:WinDir)\CCM\Staging" -Force -Recurse -Confirm:$false -Verbose
Remove-Item -Path "$($Env:WinDir)\CCM\Temp" -Force -Recurse -Confirm:$false -Verbose
Remove-Item -Path "$($Env:WinDir)\CCM\UATData" -Force -Recurse -Confirm:$false -Verbose
Remove-Item -Path "$($Env:WinDir)\CCM\systemtemp" -Force -Recurse -Confirm:$false -Verbose
Remove-Item -Path "$($Env:WinDir)\CCM" -Force -Recurse -Confirm:$false -Verbose
Remove-Item -Path "$($Env:WinDir)\CCMSetup" -Force -Recurse -Confirm:$false -Verbose
Remove-Item -Path "$($Env:WinDir)\CCMCache" -Force -Recurse -Confirm:$false -Verbose
Remove-Item -Path "$($Env:WinDir)\smscfg.ini" -Force -Confirm:$false -Verbose
Remove-Item -Path 'HKLM:\Software\Microsoft\SystemCertificates\SMS\Certificates\*' -Force -Confirm:$false -Verbose
Remove-Item -Path 'HKLM:\SOFTWARE\Microsoft\CCM' -Force -Recurse -Verbose
Remove-Item -Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\CCM' -Force -Recurse -Confirm:$false -Verbose
Remove-Item -Path 'HKLM:\SOFTWARE\Microsoft\SMS' -Force -Recurse -Confirm:$false -Verbose
Remove-Item -Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\SMS' -Force -Recurse -Confirm:$false -Verbose
Remove-Item -Path 'HKLM:\Software\Microsoft\CCMSetup' -Force -Recurse -Confirm:$false -Verbose
Remove-Item -Path 'HKLM:\Software\Wow6432Node\Microsoft\CCMSetup' -Force -Confirm:$false -Recurse -Verbose

# Remove the service from "Services"
Remove-Item -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\CcmExec' -Force -Recurse -Confirm:$false -Verbose
Remove-Item -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\ccmsetup' -Force -Recurse -Confirm:$false -Verbose

# Remove the Namespaces from the WMI repository
Get-CimInstance -query "Select * From __Namespace Where Name='CCM'" -Namespace "root" | Remove-CimInstance -Verbose -Confirm:$false
Get-CimInstance -query "Select * From __Namespace Where Name='CCMVDI'" -Namespace "root" | Remove-CimInstance -Verbose -Confirm:$false
Get-CimInstance -query "Select * From __Namespace Where Name='SmsDm'" -Namespace "root" | Remove-CimInstance -Verbose -Confirm:$false
Get-CimInstance -query "Select * From __Namespace Where Name='sms'" -Namespace "root\cimv2" | Remove-CimInstance -Verbose -Confirm:$false

# Alternative command for WMI Removal in case of something goes wrong with the above.
# Get-WmiObject -query "Select * From __Namespace Where Name='CCM'" -Namespace "root" | Remove-WmiObject -Verbose | Out-Host
# Get-WmiObject -query "Select * From __Namespace Where Name='CCMVDI'" -Namespace "root" | Remove-WmiObject -Verbose | Out-Host
# Get-WmiObject -query "Select * From __Namespace Where Name='SmsDm'" -Namespace "root" | Remove-WmiObject -Verbose | Out-Host
# Get-WmiObject -query "Select * From __Namespace Where Name='sms'" -Namespace "root\cimv2" | Remove-WmiObject -Verbose | Out-Host



ForEach ($Item in $Prog) {Write-Host $Item}

Exit-PSSession  }

 $Prog = " "
