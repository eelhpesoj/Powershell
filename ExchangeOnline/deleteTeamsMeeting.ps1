
<#
.SYNOPSIS
    This script is deleting all of the reccurence teams meeting from the specific email address.

.DESCRIPTION
    This content search can be show on the purview.microsoft.com portal.

.NOTES
    About the module:
    ExchangeOnlineManagement: 2.9 and more
#>

# Connect the modules
Connect-ExchangeOnline 
Connect-IPPSSession -EnableSearchOnlySession

# Set the name of the content search
$SearchName = "purgeSched"

# Address reccurence teams meeting
$Query = '(kind:meetings OR ItemClass:IPM.Appointment*) AND From:“joseph.lee@softwareone.com” AND (“Microsoft Teams” OR “teams.microsoft.com”)'

# Create the Content Search object
New-ComplianceSearch -Name $SearchName -ExchangeLocation All -ContentMatchQuery $Query

# Start the search
start-ComplianceSearch -Identity $SearchName

# Get the status of the search
Get-ComplianceSearch -Identity $SearchName

# Do the purge for the search
New-ComplianceSearchAction -SearchName $SearchName -Purge -PurgeType HardDelete -Force

# Get the status of the Action
Get-ComplianceSearchAction -Identity "$($searchName)_Purge"