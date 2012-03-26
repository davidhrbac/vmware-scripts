Connect-VIServer vcs1.vsb.cz
Get-Cluster | get-vmhost | Get-VMHostStorage -RescanAllHBA
