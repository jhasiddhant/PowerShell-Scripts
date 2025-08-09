Connect-AzAccount

$scope = "/subscriptions/<subscriptionID>/resourceGroups/<resourceGroupName>"      # Scope at which role is assigned
$principalId = "<object id>"                                                       # Enter object ID of userid
$justification = "<justification>"                                                 # Enter your justification
$startTime = (Get-Date).ToUniversalTime().ToString("o")                            # Use custom date to schedule PIM for future, leave as it is for current date
$duration = "PT8H"                                                                 # Duration of the role (cannot exceed the max time allotted)

$roleDefinitions = @(
    "b24988ac-6180-42a0-ab88-20f7382dd24c",   # Contributor
    "ba92f5b4-2d11-453d-a403-e96b0029c9fe"    # Storage Blob Data Contributor
    # Add more guid of role definitions as needed
)

foreach ($roleDefinitionId in $roleDefinitions) {
    $guid = [guid]::NewGuid().ToString()
    $fullRoleDefinitionId = "/providers/Microsoft.Authorization/roleDefinitions/$roleDefinitionId"

    New-AzRoleAssignmentScheduleRequest `
        -Name $guid `
        -Scope $scope `
        -ExpirationDuration $duration `
        -ExpirationType "AfterDuration" `
        -PrincipalId $principalId `
        -RequestType "SelfActivate" `
        -RoleDefinitionId $fullRoleDefinitionId `
        -ScheduleInfoStartDateTime $startTime `
        -Justification $justification
}