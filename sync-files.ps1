#Let's create a 1 one way sync

$Source = "C:\Temp\*"
$Dest = "C:\Temp2"

$HashSource = Get-FileHash $Source -Verbose
$HashDest = Get-FileHash "C:\temp2\*" -Verbose

$Compare = Compare-Object -ReferenceObject $HashSource -DifferenceObject $HashDest -Property Hash

if ($Compare.SideIndicator -ne !$compare.sideindicator){
    if ($compare.SideIndicate -eq "=>") {Delete-file}
    if ($compare.SideIndicate -eq "<=") {Copy-files}
}
     
<#  If file is in $Source but not in $dest then copy files $from source
    If file is in $dest but no in $source then delete file in $dest

    If files exist in both locations then check last modified date, copy files from $source if different
    If files exist in both location, and has same modifified date, check hash and copy from $source if different
    #>