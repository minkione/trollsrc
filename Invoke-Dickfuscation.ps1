<#
.Synopsis
   Puts a dick in your code
.DESCRIPTION
   Seriously, we just overwrite the 'This program cannot be run in DOS mode' string with an ASCII cock
.EXAMPLE
   Invoke-Dickfuscation C:\temp\mimikatz.exe
.EXAMPLE
   Another example of how to use this cmdlet
#>
Param
(
    # Param1 help description
    [Parameter(Mandatory=$true,
                ValueFromPipelineByPropertyName=$true,
                Position=0)]
    $target
)
# Make destination filename from $target
$destfile =  "Dicked" + ($target | Split-Path -Leaf)
$destination = ($target | Split-Path) + '\' + $destfile
$dick = "8==========================================================================D"
# Get dickbytes
$dickbytes = [System.Text.Encoding]::ASCII.GetBytes($dick)
$filebytes = [System.IO.File]::ReadAllBytes($target)
# Write dickbytes to the 78-153 offset
$newfile = $filebytes[0..77] + $dickbytes + $filebytes[154..($filebytes.Count)]
# Save the dicked-down executable
[io.file]::WriteAllBytes($destination,$newfile)
Write-Host "Successfully backdoored $target" 
write-host "and wrote $destination"
