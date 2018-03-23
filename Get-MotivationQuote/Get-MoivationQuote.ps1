#Created for the purpose of testing SELENiUM

<#
1. GEt DLLs
2. USe DLL to open a website
3. USe DLL to fetch the quote
4. Would be nice to make it work with PS 6.0
#>
[CmdletBinding]
$PSScriptRoot

$DriverFile = Join-Path -Path (Get-Location).Path -ChildPath file.txt

Test-Path $DriverFile

Function Get-ChromeDriver {

    $url = 'https://chromedriver.storage.googleapis.com/2.37/chromedriver_win32.zip'
$output = "$PSScriptRoot\chromedriver.zip"
$start_time = Get-Date 

Invoke-WebRequest -Uri $url -OutFile $output
Expand-Archive -Path $output -DestinationPath $PSScriptRoot
Remove-Item $output
}

If (-not(Test-Path -Path $PSScriptRoot\chromedriver.exe)) {Get-ChromeDriver}

function Remove-ChromeDriver {
    Remove-Item "$PSScriptRoot\chromedriver.exe"
} 
