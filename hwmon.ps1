$cpu = Get-CimInstance Win32_Processor
$cores = $cpu.NumberOfCores
$threads = $cpu.NumberOfLogicalProcessors
$model = $cpu.Name
$speed = $cpu.MaxClockSpeed
Write-Output "CPU: $model | $cores Core, $threads Thread | $speed MHz"

$ramTotal = (Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB
$ramFree = (Get-Counter '\Memory\Available MBytes').CounterSamples.CookedValue / 1024
$ramUsed = $ramTotal - $ramFree
$ramUsagePercent = ($ramUsed / $ramTotal) * 100

$swapTotal = (Get-CimInstance Win32_PageFileUsage).AllocatedBaseSize / 1024
$swapUsed = (Get-CimInstance Win32_PageFileUsage).CurrentUsage / 1024
$swapFree = $swapTotal - $swapUsed
$swapUsagePercent = ($swapUsed / $swapTotal) * 100

$diskInfo = Get-CimInstance Win32_LogicalDisk | ForEach-Object {
    $total = $_.Size / 1GB
    $free = $_.FreeSpace / 1GB
    $used = $total - $free
    $usagePercent = ($used / $total) * 100
    [PSCustomObject]@{
        Drive = $_.DeviceID
        TotalGB = [math]::Round($total,2)
        UsedGB = [math]::Round($used,2)
        FreeGB = [math]::Round($free,2)
        UsagePercent = [math]::Round($usagePercent,2)
    }
}

$totalDiskSpace = ($diskInfo | Measure-Object -Property TotalGB -Sum).Sum
$totalUsedSpace = ($diskInfo | Measure-Object -Property UsedGB -Sum).Sum
$totalFreeSpace = ($diskInfo | Measure-Object -Property FreeGB -Sum).Sum
$totalUsagePercent = ($totalUsedSpace / $totalDiskSpace) * 100

Write-Output "Total Disk Usage:"
$totalDiskTable = [PSCustomObject]@{
    TotalGB = [math]::Round($totalDiskSpace,2)
    UsedGB = [math]::Round($totalUsedSpace,2)
    FreeGB = [math]::Round($totalFreeSpace,2)
    UsagePercent = [math]::Round($totalUsagePercent,2)
}
$totalDiskTable | Format-Table -AutoSize

Write-Output "GPU Information:"
$gpuInfo = Get-CimInstance Win32_VideoController | ForEach-Object {
    [PSCustomObject]@{
        Model = $_.Name
        MemoryGB = [math]::Round($_.AdapterRAM / 1GB,2)
    }
}
$gpuInfo | Format-Table -AutoSize

Write-Output "Network Interfaces:"
$networkInfo = Get-CimInstance Win32_NetworkAdapterConfiguration | Where-Object { $_.IPEnabled -eq $true } | ForEach-Object {
    [PSCustomObject]@{
        Interface = $_.Description
        MACAddress = $_.MACAddress
        IPAddress = ($_.IPAddress -join ", ")
    }
}
$networkInfo | Format-Table -AutoSize

Write-Output "RAM Usage:"
$ramTable = [PSCustomObject]@{
    TotalGB = [math]::Round($ramTotal,2)
    UsedGB = [math]::Round($ramUsed,2)
    FreeGB = [math]::Round($ramFree,2)
    UsagePercent = [math]::Round($ramUsagePercent,2)
}
$ramTable | Format-Table -AutoSize

Write-Output "Swap Usage:"
$swapTable = [PSCustomObject]@{
    TotalGB = [math]::Round($swapTotal,2)
    UsedGB = [math]::Round($swapUsed,2)
    FreeGB = [math]::Round($swapFree,2)
    UsagePercent = [math]::Round($swapUsagePercent,2)
}
$swapTable | Format-Table -AutoSize

Write-Output "Disk Partitions:"
$diskInfo | Format-Table -AutoSize
