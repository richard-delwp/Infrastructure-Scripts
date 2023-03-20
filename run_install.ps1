#Azure Subscription I want to use
$subscriptionId = "4e11321a-3a7a-4b12-9d16-bdec018765e5" # Example Subscription ID
$resourceGroup = "RG-DEV-ASE-NETWORK" # Example resource group selection

# Set subscription
Set-AzContext -Subscription $subscriptionId

#Azure Subscription I want to use
$subscriptionId = "4e11321a-3a7a-4b12-9d16-bdec018765e5" # Example Subscription ID
#$resourceGroup = "RG-DEV-ASE-NETWORK" # Example resource group selection
$resourceGroup = "rg-tst-ase-network" # Example resource group selection



# Set subscription
Set-AzContext -Subscription $subscriptionId
#Get all Azure VMs which are in running state and are running Windows
$myAzureVMs = Get-AzVM -ResourceGroupName $resourceGroup -status | Where-Object {$_.PowerState -eq "VM running" -and $_.StorageProfile.OSDisk.OSType -eq "Windows"}

#Run the scirpt again all VMs in parallel
$myAzureVMs | ForEach-Object -Parallel {
    Write-Output $_.Name
    $out = Invoke-AzVMRunCommand `
        -ResourceGroupName $_.ResourceGroupName `
        -Name $_.Name  `
        -CommandId 'RunPowerShellScript' `
        -ScriptPath .\agent_install.ps1
    #Formating the Output with the VM name
    $output = $_.Name + " " + $out.Value[0].Message
    $output   
} -ThrottleLimit 5
