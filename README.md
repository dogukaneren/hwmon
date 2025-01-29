# hwmon
Hardware Monitoring Tool
##Usage
Simply download the powershell file and run it :)

``` powershell
PS C:\Users\deren\Desktop> .\hwmon.ps1

CPU: 13th Gen Intel(R) Core(TM) i7-1370P | 14 Core, 20 Thread | 1900 MHz
Total Disk Usage:

TotalGB UsedGB FreeGB UsagePercent
------- ------ ------ ------------
 579.37 296.81 282.56        51.23


GPU Information:

Model                        MemoryGB
-----                        --------
Intel(R) Iris(R) Xe Graphics        2


Network Interfaces:

Interface                             MACAddress        IPAddress
---------                             ----------        ---------
Intel(R) Wi-Fi 6E AX211 160MHz        50:28:FF:FF:FF:FF 10.10.10.10, fe80::ffff:3fe3:2222:5555
VirtualBox Host-Only Ethernet Adapter 0A:00:27:00:00:2D 192.168.56.1, fe80::9b18:d6d0:c9fc:5288


RAM Usage:

TotalGB UsedGB FreeGB UsagePercent
------- ------ ------ ------------
  31.69  19.88  11.82        62.71


Swap Usage:

TotalGB UsedGB FreeGB UsagePercent
------- ------ ------ ------------
      5   0.09   4.91         1.78


Disk Partitions:

Drive TotalGB UsedGB FreeGB UsagePercent
----- ------- ------ ------ ------------
C:      79.37  66.69  12.68        84.02
D:        300  124.2  175.8         41.4
E:        200 105.92  94.08        52.96

```

Note: If execution policy is disabled on your host, simply run this command to run.

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned -f
```
