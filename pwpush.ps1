#The idea is to use powershell to interact andgenerate passwords links

$IE = New-Object -ComObject "InternetExplorer.Application"

$RequestURI = "https://pwpush.com"
$Password = "password_payload";
$SubmitButton = "submit";

$IE.Visible = $true
$IE.Silent = $true
$IE.Navigate($RequestURI)
While ($IE.Busy) {
    Start-Sleep -Milliseconds 100
}

$Doc = $IE.Document
$Doc.getElementsByTagName("input") | ForEach-Object {
    if ($_.id -ne $null){
        if ($_.id.contains($SubmitButton)) {$SubmitButton = $_}
        if ($_.id.contains($Password)) {$Password = $_}
    }
}

$Password.value = "1234"
$SubmitButton.click()

Invoke-WebRequest https://pwpush.com/assets/application-cdd96c030d1ee817dae58ac877bd0213c8ea2859b1395e7bd83ceb37dadf5bb5.js