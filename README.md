# trollsrc
PoCs to share for trolling

.\make-shortcut.ps1 will assist in generating malicious shortcut links

.\bd-lnk.ps1 will take an executable shortcut as an argument, and backdoor with a troll message payload

.\bd-lnk.ps1 -sourcepath "$env:homepath\desktop\google chrome.lnk" 
this will copy the icon to $env:homepath\trollz\linkbackup\google chrome.lnk for restoration
it will backdoor the link with a troll msg and then redirect execution to the origional application
