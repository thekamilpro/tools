<#
.SYNOPSIS
Pushes the password to pwpush.com and retrieves the link.

.DESCRIPTION

The idea behind the https://pwpush.com is to create links with password which will expire after specific time - therefore password are not left in clear text in email forever.

The Push-PWPush will generate the link with the password provided, or will generate random number as the password, if no password is provided.


.NOTES
Password requires Internet Explorer to work. Things which are going to be added:
- Custom link expriration
- More sophisticate random password
- Customised settings for random password

#>

[string]$Password   = Read-Host "Type password or leave blank for random"
[string]$Expire     = 10 #liimit 1-90
[string]$Views      = 90 #limit 1-100

If (!$Password) {$Password = (Get-Random)}

Write-Host "Using password: $Password"

$IE = New-Object -ComObject "InternetExplorer.Application"

$RequestURI = "https://pwpush.com"


$IE.Visible = $false
$IE.Silent = $true
$IE.Navigate($RequestURI)

While ($IE.Busy) {Start-Sleep -Seconds 1}

$Payload        = "password_payload"
$ExpireID       = "password_expire_after_days"
$ViewsID        = "password_expire_after_views"

$Doc = $IE.Document
$Doc.getElementsByTagName("input") | ForEach-Object {
    if ($_.id -ne $null){
        if ($_.id.contains($Payload)) {$Payload = $_}
        if ($_.id.contains($ExpireID)) {$ExpireID = $_}
        if ($_.id.contains($ViewsID)) {$ViewsID = $_}
    }
    if ($_.name -ne $null){
        if ($_.name.contains($commit)) {$SubmitButton = $_}
    }
}

$Payload.value  =    $Password
$ExpireID.value =   $Expire
$ViewsID.value  =   $Views
Start-sleep -Seconds 1
$SubmitButton.click()

While ($IE.Busy) {Start-Sleep -Seconds 1}

$URL = "url"

$Doc.getElementsByTagName("input") | ForEach-Object {
    if ($_.id -ne $null){
        if ($_.id.contains($URL)) {$URL = $_}
    }
}

$URL.value
