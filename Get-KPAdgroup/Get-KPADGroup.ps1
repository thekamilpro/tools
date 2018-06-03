function Get-KPADGroup {
    [CmdletBinding()]

    Param (
        [Parameter(Mandatory, ValueFromPipeline)]
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
        Write-Verbose "Starting function"

        foreach ($group in $ADGroup) {
            
            Try {  
                $params = @{
                    'Identity'  = $group
                    'Recursive' = $Recursive
                }
            ForEach ($Member in Get-ADGroupMember @params) {
          

            [PSCustomObject]@{
                Group = $group
                User  = $Member.name
                Mail  = $Member.Mail
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