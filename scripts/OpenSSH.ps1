Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
Set-Service -Name sshd -Startuptype 'Automatic'
Set-Service -Name ssh-agent -Startuptype 'Automatic'
Start-Service sshd
Start-Service ssh-agent
New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell -Value "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -PropertyType String -Force


New-item -Path $env:USERPROFILE -Name .ssh -ItemType Directory -force

echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD5wwV3ZtMqdB8rcg/vHko7isD82F7IEio+5MpPTBRfYsa5933PTf9sJhJvfYN/ub1vbzVLU3ardEhbIXJZK5MeY1LngwNLTpPCIU9qcWA5qi7k/4B+j24fQ0/xCQKFjhHwXdsEjYn/ZnbsjyisEbuJtqiHcJKS0MT0HDoNNglCZ7YPo9j2oJt1t9qYEhtVGC07cniUisNT7YUJXSg79SWKtlD1Pq1r4JZyfjQkOuSRVqxKzfuA5bWSrRyI6NRjCiK9fhDNaqJkdRq8eIJvoFt1qenplgYbJdHUIcyHvad5Emr6zn8W8tezb1B0vdlaJFcIIbcqj0kE6OLL3tsnl+st" | Out-File $env:USERPROFILE\.ssh\authorized_keys -Encoding ascii

((Get-Content -path C:\ProgramData\ssh\sshd_config -Raw) `
-replace '#PubkeyAuthentication yes','PubkeyAuthentication yes' `
-replace '#PasswordAuthentication yes','PasswordAuthentication no' `
-replace 'Match Group administrators','#Match Group administrators' `
-replace 'AuthorizedKeysFile __PROGRAMDATA__/ssh/administrators_authorized_keys','#AuthorizedKeysFile __PROGRAMDATA__/ssh/administrators_authorized_keys') | Set-Content -Path C:\ProgramData\ssh\sshd_config

Restart-Service sshd
Restart-Service ssh-agent