<#
.SYNOPSIS
    Records anything that matched the specific domains or IP addresses in the DNS log.
    
#>

$searchTerms = @("*172.16.155.203*")
 
 
$logFile = ".\DNS.log"
$outputFile = ".\matches.txt"
 
function SearchFunc
{
 
for ($i=0; $i -lt $searchTerms.length; $i++)
    {
        $result = $args[0] -like $searchTerms[$i]
        $result | out-file -Append -NoClobber $outputFile
    }
}
 
gc $logFile -ReadCount 1000  | ForEach-Object { SearchFunc $_ } 
