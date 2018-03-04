#The idea is to use powershell to interact andgenerate passwords links

$IE = New-Object -ComObject "InternetExplorer.Application"

$RequestURI = "https://pwpush.com"
$Password = "password_payload";

$IE.Visible = $false
$IE.Silent = $true
$IE.Navigate($RequestURI)

While ($IE.Busy) {Start-Sleep -Seconds 1}

$Doc = $IE.Document
$Doc.getElementsByTagName("input") | ForEach-Object {
    if ($_.id -ne $null){
        if ($_.id.contains($Password)) {$Password = $_}
    }
    if ($_.name -ne $null){
        if ($_.name.contains($commit)) {$SubmitButton = $_}
    }
}

$Password.value = "1234"
Start-sleep -Seconds 1
$SubmitButton.click()

While ($IE.Busy) {Start-Sleep -Seconds 1}

$URL = "url"

$Doc.getElementsByTagName("input") | ForEach-Object {
    if ($_.id -ne $null){
        if ($_.id.contains($URL)) {$URL = $_}
    }
}
$Password.value
$URL.value
