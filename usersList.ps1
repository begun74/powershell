Import-Module ActiveDirectory



function get-adusers() {
	
	Param(
		[Parameter(Mandatory=$false)] [String]$isEnabled="True"
	)

	###Write-Output "isEnabled - " $isEnabled

	###### $listAdusers = Get-ADUser -Filter {Name -like "qwe*"} -SearchBase "OU=ГК ИНТЕРФАРМАКС,DC=interfarmax,DC=local" -Properties * | select Name,SID,PostalCode | Export-Csv '.\ifx_local.csv'

	$listAdusers = (Get-ADUser -Filter {Name -like "qwe*" -and Enabled -eq $isEnabled} -SearchBase "OU=ГК ИНТЕРФАРМАКС,DC=interfarmax,DC=local" -Properties *)

	return $listAdusers
}


function set-adusers() {

	$listAdusers = get-adusers     #Array of ADUsers
	
	
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


function move-aduser () {
	
}

function main() {

	set-adusers
}

main

