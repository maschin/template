
Function Set-Network {
    # Get network connections
    $networkListManager = [Activator]::CreateInstance([Type]::GetTypeFromCLSID([Guid]"{DCB00C01-570F-4A9B-8D69-199FDBA5723B}"))
    $connections = $networkListManager.GetNetworkConnections()

    $connections |foreach {
        Write-Host $_.GetNetwork().GetName()"category was previously set to"$_.GetNetwork().GetCategory()
        $_.GetNetwork().SetCategory(1)
        Write-Host $_.GetNetwork().GetName()"changed to category"$_.GetNetwork().GetCategory()
    }
}


Function Enable-WinRM {
Write-Host "Enable WinRM"
Set-Network

netsh advfirewall firewall set rule group="Windows Remote Administration" new enable=yes
netsh advfirewall firewall set rule name="Windows Remote Management (HTTP-In)" new enable=yes action=allow

Enable-PSRemoting -Force
winrm quickconfig -q
winrm quickconfig -transport:http
winrm set winrm/config '@{MaxTimeoutms="1800000"}'
winrm set winrm/config/winrs '@{MaxMemoryPerShellMB="800"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'
winrm set winrm/config/client/auth '@{Basic="true"}'
winrm set winrm/config/listener?Address=*+Transport=HTTP '@{Port="5985"}'

Set-Service winrm -startuptype "auto"
Restart-Service winrm

}

Enable-WinRM
