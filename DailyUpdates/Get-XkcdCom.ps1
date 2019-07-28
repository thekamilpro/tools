#Function Get-XkcdCom {
    #This function will retrieve a today's strip from Dilbert.com website
    
    
        [CmdletBinding()]
    
        param ()
    
    #URL
    $URI = 'https://xkcd.com/'
    Write-Verbose "Setting URI"
    
    $URL = $URI
    Write-Verbose "Creating URL for request"
    
    #Initial request
    $Req = Invoke-WebRequest -Uri $URL
    Write-Verbose "Sending initial request"

    #Extract String with the link to the current comic
    $String = $Req.Content -split '\n' | Select-String "Image URL \(for hotlinking\/embedding\)\:"
    Write-Verbose "Extracting string with the URL to current comic"

    #Extract URL from the string
    $URL = $String -match "(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$"
    
    Invoke-WebRequest -Uri $Matches[0] -OutFile C:\temp\xkcd.png
    Write-Verbose "Saving file"
  
    #} #function