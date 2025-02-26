function Get-ScriptDirectory{
    $Invocation = (Get-Variable MyInvocation -Scope 1).Value
    try {
        Split-Path $Invocation.MyCommand.Path -ea 0
    }
    catch {
        Write-Warning 'You need to call this function from within a saved script.'
    }
}
# change directory to this folder
$sd = Get-ScriptDirectory
Set-Location $sd

$machine =  $env:computername

# load parameters from masterconfig xml file
[xml] $master_config = get-content "master_config.xml"
$installation_folder=$master_config.selectSingleNode("config/machine[@name='$machine']/installation_folder").'#text'
#$backup_folder=$master_config.selectSingleNode("config/machine[@name='$machine']/backup_folder").'#text'

$tree_changes= (resolve-path '..\..\Innovator\').Path
#$xml_change= (resolve-path '..\..\src\Production\').Path
#$xml_to_copy= $xml_change + 'InnovatorServerConfig.xml'

# backup current Innovator tree to backup folder, this may take a while, folder > 1GB ///TODO errors on filepath length
#copy-item -path $installation_folder -Destination $backup_folder -Recurse -Confirm -Force
# update InnovatorServerConfig to be deployed, ///TODO why is this necessary
# copy-item $xml_to_copy -Destination $installation_folder -Recurse -Confirm -Force
# copy tree changes to deployment destination
copy-item -path $tree_changes -Destination $installation_folder -Recurse -Confirm -Force














