Import-Module ActiveDirectory



function get-adusers() {
	
	Param(
		[Parameter(Mandatory=$false)] [String]$isEnabled="True"
	)

	###Write-Output "isEnabled - " $isEnabled

	###### $listAdusers = Get-ADUser -Filter {Name -like "qwe*"} -SearchBase "OU=ГК ИНТЕРФАРМАКС,DC=interfarmax,DC=local" -Properties * | select Name,SID,PostalCode | Export-Csv '.\ifx_local.csv'

	$listAdusers = (Get-ADUser -Filter {SamAccountName -like "qwe*" -and Enabled -eq $isEnabled} -SearchBase "OU=ГК ИНТЕРФАРМАКС,DC=interfarmax,DC=local" -Properties *)

	return $listAdusers
}


Export-ModuleMember -Function get-adusers