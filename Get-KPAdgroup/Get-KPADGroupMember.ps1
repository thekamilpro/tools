function Get-KPADGroupMember {
    [CmdletBinding()]

    Param (
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [String[]] $ADGroup,

        #[ValidateSet($True,$false)]
        [bool] $Recursive = $false
    ) #Param

    BEGIN {
        Try {
            Get-Module -Name ActiveDirectory -ErrorAction Stop | Out-Null
        }
        CATCH {
            Write-Warning -Message "Cannot load ActiveDirectory module, is RSAT installed?"
        }
    } #BEGIN

    PROCESS {
        Write-Verbose "PROCESS"

        foreach ($group in $ADGroup) {
            
            Try {  
                $params_group = @{
                    'Identity'  = $group
                    'Recursive' = $Recursive
                }
                $params_user = @{
                    Properties = 'Mail'
                }
                ForEach ($Member in Get-ADGroupMember @params_group | Get-ADUser @params_user) {

                    [PSCustomObject]@{
                        Group   = $group
                        SAM     = $Member.samAccountName
                        Mail    = $Member.Mail
                        Enabled = $Member.Enabled
                    }
                } #foreach member
            } #TRY
            Catch {
            
                Write-Verbose "Cannot find group $($group)"
        
            } #TRY/CATCH

        } #foreach group

    } #PROCESS

    END {} #END


}#function