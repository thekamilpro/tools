function Resolve-IPDNS {
<#
.SYNOPSIS
Resolves IPv4 address to DNS, or DNS to IPv4.  

.DESCRIPTION
This command uses either IPv4 or DNS name to resolve each. It puts all the data into
structured table, which can be easilly exported if needed. By defaults it's using 
1.1.1.1 DNS server.

.PARAMETER IPDNS
One or more IPs or DNS names. Values can be piped.

.PARAMETER DNSServer
Specifies which DNS server will resolve all the queries.

.EXAMPLE
Resolve-IPDNS -IPDNS bbc.com,8.8.8.8
Resolves "bbc.com" and "8.8.8.8" returning their retrospective addresses. 

.EXAMPLE
(Get-Content C:\temp\test.txt) | Resolve-IPDNS
This example will try to resolve all entries from the file

.NOTES
Createad by Kamil Procyszyn
last updated April 2018
https://kamilpro.com
#>    
    
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