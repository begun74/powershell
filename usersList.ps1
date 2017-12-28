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


function move-adusers () {
	Param(
		[Parameter(Mandatory=$false)] [Object[]]$listAdusers,
		
		[Parameter(Mandatory=$false)] [boolean]$isEnable=0
	)

	ForEach ($user in $listAdusers) { 
		if($user.GetType().Name -eq "ADUser" -and $user.Enabled -eq $isEnable) { #Проверяем тип обьекта и чтоб был отключён
		
			Write-Output  $user.Name " - " $user.Enabled
		
		}
	}

}

function main() {
	$listAdusers = get-adusers("False")     #Array of ADUsers

	set-adusers($listAdusers)

	move-adusers($listAdusers)
}

main

