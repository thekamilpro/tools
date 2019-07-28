Function Get-DilbertCom {
#This function will retrieve a today's strip from Dilbert.com website


    [CmdletBinding()]

    param ()

#Get today's date and format as per Dilbert's website
$Today = Get-Date -Format "yyyy-MM-dd"
Write-Verbose "Retriving today's date"

#URL
$URI = 'https://dilbert.com/'
Write-Verbose "Setting URI"

#Format for the today's strip
$Format = "strip/$Today"
Write-Verbose "Setting Format variable"

#Build URL for request
$URL = $URI + $Format
Write-Verbose "Creating URL for request"

#Initial request
$Req = Invoke-WebRequest -Uri $URL
Write-Verbose "Sending initial request"

#Filter out comic
$Comic = $a.Images | Where-Object {$_.OuterHTML -like "*img-responsive img-comic*"}
Write-Verbose "Filtering out Comic out if images"

#Extract title
$Title = $Comic.alt
Write-Verbose "Extracting title"

#Extact URL and remove // from the front
$Img = $Comic.src -replace "^\/{2}"
Write-Verbose "Extracting URL for the pircutre"

Invoke-WebRequest -Uri $Img -OutFile "C:\temp\$Title.jpg"
Write-Verbose "Saving file"
} #function