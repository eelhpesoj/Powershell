<#
.SYNOPSIS
    We can set the version limitation from the SPO admin centre.
    But it only can be apply for the new site.
    For the exists, we have to use this script.

.NOTES
    PnP module and the enterprise application should be created for the prerequisite.

#>

# Set the credentials
$url = "https://???-admin.sharepoint.com/"
$clientId = "e435a562-6322-491c-b669-8934bc992b43" # PnP enterprise application, Sample GUID
$credentials = Get-Credential

Connect-PnPOnline -Url $url -ClientId $clientId -Credentials $credentials

# Get the list of the active sites
$inactive = Get-PnPTenantSite | select url, LockState | Where-Object{$_.LockState -eq "readonly"}
$active = Get-PnPTenantSite | select url, LockState | Where-Object{$_.LockState -eq "unlock"}

# site url
$sites = $active.Url

# Filtering libraries
foreach($site in $sites){

    Write-Host "====================START: $site $($lib.url) ====================" -ForegroundColor DarkBlue

    Connect-PnPOnline -Url $site -ClientId $clientId -Interactive

    # Add owners for the changes of the site
    Set-PnPTenantSite -url $site -Owners @("adminswo@???.onmicrosoft.com")
    Set-PnPTenantSite -Identity $site -DenyAddAndCustomizePages:$false

    # Filtering only for the specific templates
    $libs = Get-PnPList | Where-Object{$_.BaseTemplate -in 101,116,119}
 

    # Change the library
    foreach($lib in $libs){

        if($lib.MajorVersionLimit -ne 10){

        Set-PnPList -Identity $lib.Id -EnableAutoExpirationVersionTrim $false -ExpireVersionsAfterDays 365 -MajorVersions 10 -MinorVersions 10

        }
        else{
            Write-Host "$site $($lib.url) MajorVersionLimit has already set as 10" -ForegroundColor Yellow

        }
    }

    # Get the results
    $libs = Get-PnPList | Where-Object{$_.BaseTemplate -in 101,116,119}
    $libs | select title, MajorVersionLimit

    # Remove the owner permission
    Remove-PnPSiteCollectionAdmin -Owners "adminswo@???.onmicrosoft.com"
    Set-PnPTenantSite -Identity $site -DenyAddAndCustomizePages:$true

    Write-Host "====================END: $site $($lib.url) ====================" -ForegroundColor DarkBlue

}