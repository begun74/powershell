Import-Module ActiveDirectory



function get-adusers() {
	
	Param(
		[Parameter(Mandatory=$false)] [String]$isEnabled="True"
	)

	###Write-Output "isEnabled - " $isEnabled

	###### $listAdusers = Get-ADUser -Filter {Name -like "qwe*"} -SearchBase "OU=ÃÊ ÈÍÒÅĞÔÀĞÌÀÊÑ,DC=interfarmax,DC=local" -Properties * | select Name,SID,PostalCode | Export-Csv '.\ifx_local.csv'

	$listAdusers = (Get-ADUser -Filter {SamAccountName -like "qwe*" -and Enabled -eq $isEnabled} -SearchBase "OU=ÃÊ ÈÍÒÅĞÔÀĞÌÀÊÑ,DC=interfarmax,DC=local" -Properties *)

	return $listAdusers
}


function set-adusers() {

	Param(
		[Parameter(Mandatory=$false)] [Object[]]$listAdusers
	)

	

	If($listAdusers.count -ne 0 ) {

		ForEach ($user in $listAdusers) { 
			if($user.GetType().Name -eq "ADUser") { #Ïğîâåğÿåì òèï îáüåêòà
			
				Write-Output $user.Name
			
				$Attributes = @{
					"postalCode" = $user.postOfficeBox[0]
					#"postalCode" = $user.st
				}
			
				Set-AdUser -Identity $user.SamAccountName @Attributes
			}
		}

	}
} #-- function



function main() {
	$listAdusers = get-adusers("False")     #Array of ADUsers
	#$listAdusers = get-adusers     #Array of ADUsers

	set-adusers($listAdusers)

}

main

