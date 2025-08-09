Connect-AzAccount -Subscription "<Subscription Id>"

$tenantID = "<Tenant ID>"                        # Enter your tenant ID
$subscriptionID = "<Subscription ID>"            # Enter your subscription ID
$startDateTime = Get-Date                        # Use current date and time or specify a custom date
$duration = "P1Y"                                # Duration for which the role will be assigned (e.g., P1Y for 1 year) 

$roles = @(
    "Storage Blob Data Contributor",             # Role name for Storage Blob Data Contributor
    "Contributor"                                # Role name for Contributor
    # Add more role names as needed
)

$startDateTimeUtc = $startDateTime.ToUniversalTime()

# Define resource group objects with name and principal ID
$resourceGroups = @(
    @{
        rgname = "<resourceGroupName1>"                     # Enter the name of the first resource group
        objectid = "<objectId1>"                            # Enter the object ID of the first user or group
    },
    @{
        rgname = "<resourceGroupName2>"                     # Enter the name of the second resource group
        objectid = "<objectId2>"                            # Enter the object ID of the second user or group
    }
    # Add more resource groups as needed
)

foreach ($resourceGroup in $resourceGroups) {
    $RGName = $resourceGroup.rgname
    $principalID = $resourceGroup.objectid
    $scope = "/subscriptions/$subscriptionID/resourceGroups/$RGName"

    foreach ($role in $roles) {
        $existingRole = Get-AzRoleAssignment -Scope $scope -PrincipalId $principalID -RoleDefinitionName $role -ErrorAction SilentlyContinue

        if ($existingRole) {
            Write-Host "Role '$role' is already assigned to $principalID in resource group '$scope'. Skipping."
        } else {
            New-PIMAzureResourceEligibleAssignment -tenantID $tenantID `
                -subscriptionID $subscriptionID `
                -rolename $role `
                -principalID $principalID `
                -startDateTime $startDateTimeUtc `
                -duration $duration `
                -scope $scope
            Write-Host "Assigned role '$role' to $principalID in resource group '$scope'"
        }
    }
} 