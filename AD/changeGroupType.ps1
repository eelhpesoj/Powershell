
$OU = "OU=MailUsers,DC=all,DC=run,DC=local"
$allgroup = Get-ADGroup -SearchBase $OU -Filter *
 
foreach($group in $allgroup){

    if($group.groupscope -ne "Universal"){
        
        Set-ADGroup -Identity $group -GroupScope Universal -GroupCategory Security
 
        Write-Host "$($group.DistinguishedName) is set as Universal" -ForegroundColor Green
 
    }
    else{

        Write-Host "$($group.DistinguishedName) is alreay set as Universal" -ForegroundColor Yellow
 
    }
}