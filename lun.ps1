$report = @()
$vms = Get-VM | Get-View
foreach($vm in $vms){
 foreach($dev in $vm.Config.Hardware.Device){
   if(($dev.gettype()).Name -eq "VirtualDisk"){
     if($dev.Backing.CompatibilityMode -eq "physicalMode"){
       $row = "" | select VMName, HDDeviceName, HDFileName
         $row.VMName = $vm.Name
       $row.HDDeviceName = $dev.Backing.DeviceName
       $row.HDFileName = $dev.Backing.FileName
       $report += $row
     }
   }
 }
}
$report