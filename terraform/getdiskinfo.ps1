$fileName = "disk_info.csv"
New-Item -Path . -Name $fileName -ItemType "file"
echo "vmname,vmrg,diskname,diskrg" | Add-Content -Path $fileName
$getAllVms = Get-AzVm
foreach($vm in $getAllVms)
{
    $getVm = Get-AzVm -ResourceGroupName "$($vm.ResourceGroupName)" -Name "$($vm.Name)"
    $diskInfo = $getVm.StorageProfile.OsDisk.ManagedDisk.Id.Split("/")

    Echo "$($getVm.Name),$($getVm.ResourceGroupName),$($diskInfo[8]),$($diskInfo[4])" | Add-Content -Path $fileName
}
