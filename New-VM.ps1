#Script to create a new VM in Hyper-V

[string]$VmName = Read-Host -Prompt 'Provide the name'
[string]$PathToISO = 'L:\Software\ISO\Server 2012 R2.ISO'

#Create VM
New-VM  -Name $VmName -MemoryStartupBytes 2GB -Generation 2 -Path D:\VM\$VmName -SwitchName Internal -NewVHDSizeBytes 60GB -NewVHDPath D:\VM\$VmName\$VmName.vhdx

#Configure CPU
Set-VMProcessor -VMName $VmName -Count 2

#Add ISO
Add-VMDvdDrive -VMName $VmName -Path $PathToISO

#Set to boot from ISO & switch off secure boot
$BootDVD = Get-VMDvdDrive -VMName $VmName
Set-VMFirmware -VMName $VmName -FirstBootDevice $BootDVD -EnableSecureBoot Off

#Start VM
Get-VM $VmName | Start-VM