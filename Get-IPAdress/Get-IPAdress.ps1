function Resolve-IPDNS {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string[]]$IPDNS,

        [string]$DNSServer = "1.1.1.1"

    )#param

    BEGIN {}

    Process {
        foreach ($addrs in $IPDNS ) {
        
            #Resolve IP or DNS
            IF ($addrs -as [ipaddress]) {
            $resolve_params = @{'Name' = $addrs
                'Server' = $DNSServer
                'Type' = 'PTR'}
            } ELSE {
                $resolve_params = @{'Name' = $addrs
                'Server' = $DNSServer
                'Type' = 'A'}
            }
            $resolve = Resolve-DnsName @resolve_params
        

            #Create props
            IF ($addrs -as [ipaddress]) {
                $props = @{'IP' = $resolve.Name
                    'NameHost' = $resolve.NameHost}
            } ELSE {
                    $props = @{'IP' = $resolve.IPAddress
                        'NameHost' = $resolve.Name}
                
                }#IF
       
                #Output data
                $obj = New-Object -TypeName psobject -Property $props
                Write-Output $obj
                
            }#foreach

        }#Process
        END {}
    }#function

    Resolve-IPDNS