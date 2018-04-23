function Resolve-IPDNS {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true,ValueFromPipeline = $true)]
        [string[]]$IPDNS,

        [string]$DNSServer = "1.1.1.1"

    )#param

    BEGIN {}

    Process {
        foreach ($addrs in $IPDNS ) {
        
            #Resolve IP or DNS
            IF ($addrs -as [ipaddress]) {
                $resolve_params = @{
                    'Name'   = $addrs
                    'Server' = $DNSServer
                    'Type'   = 'PTR'
                }
            }
            ELSE {
                $resolve_params = @{
                    'Name'   = $addrs
                    'Server' = $DNSServer
                    'Type'   = 'A'
                }
            }
          
            ForEach ($resolve in Resolve-DnsName @resolve_params) {

                #Create props
                IF ($addrs -as [ipaddress]) {
                    $props = @{
                        'IP'  = $resolve.Name
                        'DNS' = $resolve.NameHost
                    }
                }
                ELSE {
                    $props = @{
                        'IP'  = $resolve.IPAddress
                        'DNS' = $resolve.Name
                    }
                
                }#IF
       
                #Output data
                $obj = New-Object -TypeName psobject -Property $props
                Write-Output $obj
                
            }#Foreach $resolve in dns-resolve
        
        }#foreach $addrs in $ipdns

    }#Process
    END {}
}#function

Resolve-IPDNS