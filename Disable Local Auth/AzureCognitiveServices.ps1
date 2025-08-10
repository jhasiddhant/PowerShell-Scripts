Connect-AzAccount -Subscription "<Subscription Id>"

$resource_group_name = Read-Host "Enter the resource group name"
$cognitive_resource_name = Read-Host "Enter the Coginitive service name"
Set-AzCognitiveServicesAccount -ResourceGroupName $resource_group_name -Name $cognitive_resource_name -DisableLocalAuth $true