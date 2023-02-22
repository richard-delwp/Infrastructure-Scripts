while read svr; do
        echo $svr 
        az vm run-command invoke --resource-group RG-TST-ASE-NETWORK --name $svr --subscription 4e11321a-3a7a-4b12-9d16-bdec018765e5 --command-id RunPowerShellScript --scripts "C:
\Windows\ccmsetup\ccmsetup.exe /uninstall"
        az vm run-command invoke --resource-group RG-TST-ASE-NETWORK --name $svr --subscription 4e11321a-3a7a-4b12-9d16-bdec018765e5 --command-id RunPowerShellScript --scripts "di
r C:\Windows\ccmsetup\Logs\*"
done < servers.txt
