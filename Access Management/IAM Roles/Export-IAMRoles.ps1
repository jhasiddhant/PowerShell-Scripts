$subscriptionID = "<subscription ID>"               # Enter your subscription ID
$scope = "/subscriptions/subscriptionID"            # Enter the scope of the role assignment

Connect-AzAccount -Subscription $subscriptionID

# Retrieve role assignments for the given subscription
$roleAssignments = Get-AzRoleAssignment -Scope $scope

# Select the properties you want to export
$exportData = $roleAssignments | Select-Object `
    RoleAssignmentName, `
    Scope, `
    DisplayName, `
    SignInName, `
    RoleDefinitionName, `
    ObjectId, `
    ObjectType

# Export to CSV
$exportData | Export-Csv -Path "<Output Path>\RoleAssignments.csv" -NoTypeInformation