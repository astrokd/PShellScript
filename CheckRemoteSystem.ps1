# Script to get system data from machines
cls
$Node = "machine name here"
# OS
    $computerOS = get-wmiobject Win32_OperatingSystem -ComputerName $Node
    "Operating System: " + $computerOS.caption + ", Service Pack: " + $computerOS.ServicePackMajorVersion

# CPU
    $TheSysPro = Get-WmiObject win32_processor -ComputerName $Node
    $TheSysPro.Name
    "Cores: " + $TheSysPro.NumberOfCores
    "Logical Cores: " + $TheSysPro.NumberOfLogicalProcessors

# Memory
    $computerSystem = get-wmiobject Win32_ComputerSystem -ComputerName $Node
    "Total Memory in Gigabytes: " + $computerSystem.TotalPhysicalMemory/1gb + " GB"

# Hard Drive

    $var1 = get-wmiobject win32_logicaldisk -ComputerName $Node #| Where-Object {$_.DeviceID -like "C"}
    $var1[0].DeviceID
    "Size: " + $var1[0].Size/1000000000 +" GB"
    "Free: " + $var1[0].FreeSpace/1000000000 +" GB"
    $var1[1].DeviceID
    "Size: " + $var1[1].Size/1000000000 +" GB"
    "Free: " + $var1[1].FreeSpace/1000000000 +" GB"


# Machine Name
    "System Information for: " + $computerSystem.Name

