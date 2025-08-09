Connect-AzAccount -Subscription "<Subscription Id>"

$tenantID = "<Tenant ID>"                        # Enter your tenant ID
$subscriptionID = "<Subscription ID>"            # Enter your subscription ID

# --- Data: List of PIM assignments to be removed ---
$assignmentsToRemove = @(
    [PSCustomObject]@{
        Scope       = "/subscriptions/<Subscription ID>/resourceGroups/<resource group name>"
        RoleName    = "<Role Name to Remove>"
        PrincipalId = "<object ID of the user or group to remove>"
    },
    [PSCustomObject]@{
        Scope       = "/subscriptions/<Subscription ID>/resourceGroups/<resource group name>"
        RoleName    = "<Role Name to Remove>"
        PrincipalId = "<object ID of the user or group to remove>"
    },
    [PSCustomObject]@{
        Scope       = "/subscriptions/<Subscription ID>"
        RoleName    = "<Role Name to Remove>"
        PrincipalId = "<object ID of the user or group to remove>"
    }
)

foreach ($assignment in $assignmentsToRemove) {
    $scope = $assignment.Scope
    $roleName = $assignment.RoleName
    $principalId = $assignment.PrincipalId
    
    Write-Host "Processing removal for Principal '$principalId' with Role '$roleName' at Scope '$scope'..." -ForegroundColor Yellow

    Remove-PIMAzureResourceEligibleAssignment -tenantID $tenantID -subscriptionID $subscriptionId -scope $scope -rolename $roleName -principalID $principalId -Verbose
}