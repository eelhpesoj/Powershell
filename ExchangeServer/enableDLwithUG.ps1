
#import module or run EMS
Add-PSSnapin *exchange*
 
$OU = "OU=MailUsers,DC=all,DC=run,DC=local"
$allgroup = Get-Group -ResultSize unlimited -OrganizationalUnit $OU

foreach($group in $allgroup){
 
   if(Get-DistributionGroup -Identity $group.Name -ErrorAction SilentlyContinue){
    Write-Host "$($group.DistinguishedName) is already set as group mail" -ForegroundColor Yellow
    }
    else{
        try{
            Enable-DistributionGroup$group.Name
            Write-Host "$($group.DistinguishedName) group mail is created" -ForegroundColor Green
        }
        catch{
            Write-Host "$($group.DistinguishedName) group mail is not created" -ForegroundColor Red
        }
    }
}