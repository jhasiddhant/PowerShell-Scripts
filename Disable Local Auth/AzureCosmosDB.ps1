Connect-AzAccount -Subscription "<Subscription Id>"

$resource_group_name = Read-Host "Enter the resource group name"
$cosmos_db_resource_name = Read-Host "Enter the Cosmos DB resource name"
az resource update --ids $(az cosmosdb show --name $cosmos_db_resource_name --resource-group $resource_group_name --query id -o tsv) --set properties.disableLocalAuth=true