Import-Module ActiveDirectory
Import-Module .\usersList.psm1


function set-adusers() {

	Param(
		[Parameter(Mandatory=$false)] [Object[]]$listAdusers
	)

	

	If($listAdusers.count -ne 0 ) {

		ForEach ($user in $listAdusers) { 
			if($user.GetType().Name -eq "ADUser") { #Проверяем тип обьекта
			
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

