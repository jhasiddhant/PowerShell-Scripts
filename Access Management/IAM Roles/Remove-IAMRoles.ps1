Connect-AzAccount -Subscription "<Subscription Id>"

# Define multiple parameter sets
$paramList = @(
    @{
        Scope              = "/subscriptions/<sub-id>/resourceGroups/<rg-name>/providers/Microsoft.Storage/storageAccounts/<storage-name>"
        ObjectId           = "<object-id-1>"
        RoleDefinitionName = "<Role Name>"
    },
    @{
        Scope              = "/subscriptions/<sub-id>/resourceGroups/<rg-name>"
        ObjectId           = "<object-id-2>"
        RoleDefinitionName = "<Role Name>"
    },
    @{
        Scope              = "/subscriptions/<sub-id>"
        ObjectId           = "<object-id-3>"
        RoleDefinitionName = "<Role Name>"
    }
)

# Loop through each parameter set and remove the role
foreach ($params in $paramList) {
    try {
        Remove-AzRoleAssignment @params
        Write-Host "Removed role '$($params.RoleDefinitionName)' from object '$($params.ObjectId)' at scope '$($params.Scope)'" -ForegroundColor Green
    }
    catch {
        Write-Warning "Failed to remove role '$($params.RoleDefinitionName)' from object '$($params.ObjectId)': $_"
    }
}
