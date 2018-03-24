#Created for the purpose of testing SELENiUM

<#
1. GEt DLLs
2. USe DLL to open a website
3. USe DLL to fetch the quote
4. Would be nice to make it work with PS 6.0
#>
#[CmdletBinding]

$DriverFile = Join-Path -Path (Get-Location).Path -ChildPath file.txt

Test-Path $DriverFile


Function Get-WebDriver {

    $url = 'https://goo.gl/aa746n'
    $output = "$PSScriptRoot\webdriver.zip"
    
    Invoke-WebRequest -Uri $url -OutFile $output
    Expand-Archive -Path $output -DestinationPath $PSScriptRoot -Force
    Remove-Item $output

    Install-Package "$PSScriptRoot\dist\Selenium.WebDriver.3.9.1.nupkg" -Verbose
    }
function Get-ChromeDriver {

$url = 'https://chromedriver.storage.googleapis.com/2.37/chromedriver_win32.zip'
$output = "$PSScriptRoot\chromedriver.zip"

Invoke-WebRequest -Uri $url -OutFile $output
Expand-Archive -Path $output -DestinationPath $PSScriptRoot -Force
Remove-Item $output
}

function Remove-ChromeDriver {
    Remove-Item "$PSScriptRoot\chromedriver.exe"
    Remove-Item "$PSScriptRoot\dist*" -Recurse
} 



If (-not(Test-Path -Path $PSScriptRoot\chromedriver.exe)) {Get-ChromeDriver}

Get-WebDriver -Verbose

Remove-ChromeDriver