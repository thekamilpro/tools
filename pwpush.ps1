#The idea is to use powershell to interact andgenerate passwords links

$IE = New-Object -ComObject "InternetExplorer.Application"

$RequestURI = "https://pwpush.com"
$Password = "password_payload";
$SubmitButton = "commit";

$IE.Visible = $true
$IE.Silent = $true
$IE.Navigate($RequestURI)
While ($IE.Busy) {
    Start-Sleep -Milliseconds 100
}

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

$PasswordURL = 'value'

$Doc.getElementsByTagName("input") | ForEach-Object {
    if ($_.value -ne $null){
        if ($_.value.contains($PasswordURL)) {$PasswordURL = $_}
    }
}
$PasswordURL.value
Start-Sleep -Seconds 1