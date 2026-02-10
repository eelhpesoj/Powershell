$getNewOutlook = Get-AppPackage Microsoft.OutlookForWindows -AllUsers -ErrorAction SilentlyContinue

if($getNewOutlook){

$getNewOutlook | Remove-AppPackage -AllUsers

    exit

}

else {

    exit

}
