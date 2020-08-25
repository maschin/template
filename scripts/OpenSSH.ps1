Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0 | Out-File -FilePath C:\log.txt -NoNewline
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0 | Out-File -FilePath C:\log.txt -NoNewline
Set-Service -Name sshd -Startuptype 'Automatic'
Set-Service -Name ssh-agent -Startuptype 'Automatic'
Start-Service sshd
Start-Service ssh-agent
New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell -Value "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -PropertyType String -Force


