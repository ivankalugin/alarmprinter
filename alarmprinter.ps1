$printer = "http://192.168.1.70:631/printers/alarmprinter"
$key = (Get-Item HKLM:\).OpenSubkey("SYSTEM\CurrentControlSet\Control\Print\Providers\Internet Print Provider\Ports\", $true).CreateSubKey($printer)
$key.SetValue('Authentication', '0', 'Dword')
$key.SetValue('Password', (New-Object byte[] 0), 'Binary')
$key.SetValue('UserName', (New-Object byte[] 0), 'Binary')

Restart-Service Spooler -Force

Add-Printer -Name "alarmprinter" -DriverName "Generic / Text Only" -PortName $printer
