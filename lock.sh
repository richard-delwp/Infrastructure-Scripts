envs=$1

while read env; do
        subs=`echo $env | awk '{print $1}'`
        rg=`echo $env | awk '{print $2}'`
        az vm list --subscription $subs --resource-group $rg --output table --query "[].name" > rg.txt
        tail -n +3 rg.txt > servers.txt; rm rg.txt

        while read svr; do
                echo "---------------------------------------------" 
                az lock create --name Lock_$svr --lock-type CanNotDelete --subscription $subs --resource-group $rg --resource-name $svr --resource-type Micro
soft.Compute/virtualMachines
        done < servers.txt
        rm servers.txt

        echo "VM Locks in Resource Group: $rg"
        az lock list --subscription $subs --resource-group $rg --output table | grep "Lock_"
done < $1
