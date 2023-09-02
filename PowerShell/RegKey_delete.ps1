'''

...This script search and delete an array of registry keys in Windows 10/11... 

..if you consider a better way to perform this task do not hesitate to update it...
                                                                                               
                                                                                            
'''
#Asking for admin rights
if(!([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) 
{
    Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList "-File `"$($MyInvocation.MyCommand.Path)`"  `"$($MyInvocation.MyCommand.UnboundArguments)`""
    Exit
}

# Write the names of the $keys that you want to delete
$keys = @("CETASvc", "CloudEndPointService", "TmkKmSnsr", "TmResponse");

# Common registry key paths use it
$paths = @("HKLM:\SOFTWARE\", "HKLM:\SYSTEM\Services\", "HKLM:\SYSTEM\ControlSet001\Services\");

Write-Host "Those REGISTRE KEYs Will Remove: " $keys;
$Confirm = Read-Host "Are you sure about remove it (y/n):"
if ($Confirm -eq "y") {
    foreach ($file in $keys) {
        foreach ($location in $paths) {
            $location = $location + $file;
            if (Test-Path $location) {
                try {
                    Remove-ItemProperty -Path $location -Name $file;
                    Write-Output  $location + " REMOVED CORRECTLY"; 
                }
                catch {
                    Write-Output  "Something wrong happend trying to delete: " + $location; 
                }
                
            }
        }
    }
    Write-Host "Key removed!";
}
else {
    Write-Output "Try again when you are sure";
}

'''

Created by AndoRoman

'''