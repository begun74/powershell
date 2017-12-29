Import-Module ActiveDirectory
Import-Module .\usersList.psm1


function move-adusers () {
	Param(
		[Parameter(Mandatory=$false,Position=0)] [Object[]]$listAdusers,

		[Parameter(Mandatory=$false,Position=1)] [boolean]$isEnable=0,

		[Parameter(Mandatory=$false,Position=2)] [string]$Target_Path = "OU=Уволенные,OU=ГК ИНТЕРФАРМАКС,DC=interfarmax,DC=local"

	)

	#Write-Host   "Target_Path - "  $Target_Path 

	ForEach ($user in $listAdusers) { 
		if($user.GetType().Name -eq "ADUser" -and $user.Enabled -eq $isEnable) { #Проверяем тип обьекта и чтоб был отключён
		
			Write-Host   $user "  -moved to-  "  $Target_Path 
			Move-ADObject -Identity $user -TargetPath $Target_Path
		}
	}

}

function main() {
	$listAdusers = get-adusers("False")     #Array of ADUsers
	#$listAdusers = get-adusers     #Array of ADUsers

	move-adusers($listAdusers)
}

main