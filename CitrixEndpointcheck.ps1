#Citrix Client
$CTXinfo = Get-WmiObject -Namespace root\Citrix\euem -Class citrix_euem_clientConnect

$endpoint = $CTXinfo.ClientMachineName

        # ComputerSystem info
        $CompInfo = GWMI Win32_ComputerSystem -comp $endpoint

        # OS info
        $OSInfo = GWMI Win32_OperatingSystem -comp $endpoint

        # Bios No
        $BiosInfo = GWMI Win32_BIOS -comp $endpoint

        # Drive
        $DriveInfo = get-wmiobject win32_logicaldisk -ComputerName $endpoint | Where-Object {$_.DeviceID -like "C:"}

        # CPU Info
        $CPUInfo = GWMI Win32_Processor -comp $endpoint

        # Video
        $Vidinfo = GWMI win32_videocontroller -Comp $endpoint

        # Monitor
        $MonInfo = Get-WmiObject win32_desktopmonitor -Comp $endpoint

        #Battery
        $Battinfo = GWMI win32_battery -Comp $endpoint

        #network
        $NetInfo = GWMI -class Win32_PerfFormattedData_Tcpip_NetworkInterface -Comp $endpoint

        #sound
        $SoundInfo = Get-CimInstance win32_sounddevice -ComputerName $endpoint

        #USB
        $USBinfo = Get-WmiObject Win32_USBDevice -ComputerName $endpoint

        #Printer
        $PrinterInfo = GWMI win32_printer -ComputerName $endpoint

        "System Information for: " + $CompInfo.Name 
        "Citrix Client Machine Name and IP: " + $CTXinfo.ClientMachineName + "  " + $CTXinfo.ClientMachineIP
        "Operating System: " + $OSInfo.caption + ", Service Pack: " + $OSInfo.ServicePackMajorVersion
        "System Model: " + $CompInfo.Model
        "CPU: " + $CPUInfo.Name
        "Total Memory in Gigabytes: " + [math]::round($CompInfo.TotalPhysicalMemory/1gb) + " GB"
        "Video Card: " + $Vidinfo.caption
        "GPU RAM: " + [math]::round($Vidinfo.AdapterRAM/1000000000, 2) 
        "Vert Res: " + $Vidinfo.CurrentVerticalResolution
        $MonInfo.Name
        "Estimated Charge in %: " + $Battinfo.EstimatedChargeRemaining
        "Bandwidth: " + $NetInfo.CurrentBandwidth
        "Drive " + $DriveInfo.DeviceID
        "Size: " + [math]::round($DriveInfo.Size/1000000000) +" GB"
        "Free: " + [math]::round($DriveInfo.FreeSpace/1000000000) +" GB"
        "Last Reboot: " + $OSInfo.ConvertToDateTime($OSInfo.LastBootUpTime)
        "Sound: " + $SoundInfo.Name
        "USB Audio device: " + ($USBinfo | Where-Object{$_.Service -match 'usbaudio'}).Name
        "Printers: " + $PrinterInfo.Name