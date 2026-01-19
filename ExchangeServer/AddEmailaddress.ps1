Add-PSSnapin *exchange*

$users = Get-Mailbox -ResultSize unlimited


foreach($user in $users){

    try{
        Set-Mailbox -Identity $user -EmailAddresses @{Add="smtp:$($user.samaccountname)@cake.run.place"}
        Write-Host "Add smtp to $($user) succeed" -ForegroundColor Green
    
    }
    catch{
        Write-Host "Add smtp to $($user) failed" -ForegroundColor Red
    }
}