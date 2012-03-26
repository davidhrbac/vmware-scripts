$startd=date
write-host $startd 
Connect-VIServer vcs1.vsb.cz
$servers=Get-VM -Datastore sanb01
foreach ($server in $servers)
{
write-host $server
move-vm -vm $server -Datastore sana01 -DiskStorageFormat thin
}
$endd=date
write-host $startd 
write-host $endd 

