env=$1
subs=`head -1 $env`
rg=`head -2 $env | tail -1`
cmd=("systeminfo")
file=$1.out
tail -n +3 $env > $file.servers

if [ -f "$file.out" ] ; then
    rm "$file.out"
fi
if [ -f "$file.work" ] ; then
    rm "$file.work"
fi

while read svr; do
        az vm run-command invoke --resource-group $rg --name $svr --subscription $subs --command-id RunPowerShellScript --scripts "$cmd" >> $file.work
        fold -w 140 < $file.work > $file.tmp ; cat $file.tmp | grep -i "OS Name" |& tee $file ; rm $file.tmp
done < $file.servers
rm $file.servers; rm $file.work
