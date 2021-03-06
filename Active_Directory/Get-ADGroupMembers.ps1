<#
.SYNOPSIS
    Gets a listing of all groups in a domain along with their member's display name and usernames

.LINK
    
#>


$Groups = (Get-AdGroup -filter * | Where {$_.name -like "**"} | select name -ExpandProperty name)

$Table = @()

$Record = @{
  "Group Name" = ""
  "Name" = ""
  "Username" = ""
}


Foreach ($Group in $Groups) {
  Try
  {
  $Arrayofmembers = Get-ADGroupMember -identity $Group -recursive | select name,samaccountname -ErrorAction SilentlyContinue
  }
  Catch
  {
  # Does nothing,  it is just here to hide errors from the screen.
  }

  foreach ($Member in $Arrayofmembers) {
    $Record."Group Name" = $Group
    $Record."Name" = $Member.name
    $Record."UserName" = $Member.samaccountname
    $objRecord = New-Object PSObject -property $Record
    $Table += $objrecord

  }
}
$Table | out-gridview