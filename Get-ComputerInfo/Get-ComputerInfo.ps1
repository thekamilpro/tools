[CmdletBinding()]

Param(
    [Parameter(Position=1)]
    $ComputerName = "localhost"
)

function Get-ComputerInfo {
#ComputerSystem
$Hostname = Get-CimInstance -ClassName Win32_ComputerSystem | Select-Object Name
$Manufacturer = Get-CimInstance -ClassName Win32_ComputerSystem | Select-Object Manufacturer
$Model = Get-CimInstance -ClassName Win32_ComputerSystem | Select-Object Model
#OperatingSystem
$SystemDrive = Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object SystemDrive
$SystemDrive = $SystemDrive.SystemDrive
$SystemDrive = Get-CimInstance -ClassName Win32_LogicalDisk -filter "Name like '$SystemDrive'"
$BuildNumber = Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object BuildNumber
$BootTime = Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object LastBootUpTime
$Version = Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object Caption
#Processpr
$CPUName = Get-CimInstance -ClassName Win32_Processor |  Select-Object Name
$CPUID = Get-CimInstance -ClassName Win32_Processor |  Select-Object DeviceID
$CPUCores = Get-CimInstance -ClassName Win32_Processor |  Select-Object NumberOfCores
#IP
$IP = Get-NetIPAddress -AddressFamily IPv4 | Select-Object IPv4Address

$Results = New-Object -TypeName psobject -Property @{
    Hostname = $Hostname.Name
    Manufacturer = $Manufacturer.Manufacturer
    Model = $Model.Model
    SystemDrive = $SystemDrive
    BuildNumber = $BuildNumber.BuildNumber
    BootTime = $BootTime.LastBootUpTime
    OS = $Version.Caption
    CPUName = $CPUName.Name
    CPUID = $CPUID.DeviceID
    CPUCores = $CPUCores.NumberOfCores
    IP = $IP.IPv4Address
}

$Results | Select-Object Hostname,Manufacturer,Model,SystemDrive,BuildNumber,BootTime,OS,CPUName,CPUID,CPUCores,IP
}

If ($ComputerName -eq "localhost") {Get-ComputerInfo} ELSE {Invoke-Command -FilePath $PSCommandPath -ComputerName $ComputerName}