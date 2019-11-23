function Get-VSSWriter {
    [CmdletBinding()]

    Param (
        [String] $Value
    ) #Param

    BEGIN { } #BEGIN

    PROCESS {
        
        VSSAdmin list writers | 
        Select-String -Pattern 'Writer name:' -Context 0, 4 |
        ForEach-Object {

            $Name = $_.Line -replace "^(.*?): " -replace "'"
            $Id = $_.Context.PostContext[0] -replace "^(.*?): "
            $InstanceId = $_.Context.PostContext[1] -replace "^(.*?): "
            $State = $_.Context.PostContext[2] -replace "^(.*?): "
            $LastError = $_.Context.PostContext[3] -replace "^(.*?): "

            foreach ($Prop in $_) {
                 [pscustomobject]@{
                    Name       = $Name #$_.Line
                    Id         = $Id
                    InstanceId = $InstanceId
                    State      = $State
                    LastError  = $LastError
                } 
            }#foreach  
        }#foreach-object

    } #PROCESS

    END { } #END


}#function

Get-VSSWriter