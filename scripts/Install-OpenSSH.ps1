function Install-OpenSSH {
    Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
    New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell -Value "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -PropertyType String -Force
    Set-Service -Name sshd -Startuptype 'Automatic'
    Start-Service sshd
    Restart-Service sshd
}

Install-OpenSSH
