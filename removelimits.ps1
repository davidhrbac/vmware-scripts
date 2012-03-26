# we'll use the same object to remove the limit
$ResourceAllocationInfo = New-Object VMware.Vim.ResourceAllocationInfo
$ResourceAllocationInfo.Limit = -1
 
# Get the Managed object for each VM
Foreach ($VM in get-vm| sort name | get-view) {
    write-host $VM.name
    # Create a fresh VirtualMachineConfigSpec
    $VirtualMachineConfigSpec = New-object VMware.Vim.VirtualMachineConfigSpec
    $i = 0
    # If the CPU Allocation is not unlimited add CPU to our spec.
    IF ($VM.ResourceConfig.CpuAllocation.Limit -ne -1) {
        $VirtualMachineConfigSpec.cpuAllocation = $ResourceAllocationInfo
    	$i++
    }
    # If the Memory Allocation is not unlimited add Memory to our spec.
    IF ($VM.ResourceConfig.MemoryAllocation.Limit -ne -1) {
        $VirtualMachineConfigSpec.memoryAllocation = $ResourceAllocationInfo
        $i++
    }
    # If $I is gt 0 then we have a VM to fix... Trigger the reconfig task.
    IF ($I -gt 0) {
        write-verbose "Removing limits on $($VM.Name)"
        [void]$VM.ReconfigVM_Task($VirtualMachineConfigSpec)
    }
}