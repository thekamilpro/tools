Function Get-DilbertCom {
#This function will retrieve a today's strip from Dilbert.com website


    [CmdletBinding()]

    param ()

#Get today's date and format as per Dilbert's website
$Today = Get-Date -Format "yyyy-MM-dd"

#URL
$URI = 'https://dilbert.com/'

#Format for the today's strip
$Format = "strip/$Today"

#Build URL for request
$URL = $URI + $Format

#Initial request
$Req = Invoke-WebRequest -Uri $URL

#Filter out comic
$Comic = $a.Images | Where-Object {$_.OuterHTML -like "*img-responsive img-comic*"}

#Extract title
$Title = $Comic.alt

#Extact URL and remove // from the front
$Img = $Comic.src -replace "^\/{2}"

Invoke-WebRequest -Uri $Img -OutFile "C:\temp\$Title.jpg"
} #function