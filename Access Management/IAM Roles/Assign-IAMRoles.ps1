Connect-AzAccount -Subscription "<subscription-id>"

$assignments = @(
    @{ ObjectId = "<object-id-1>"; Role = "<Role 1>"; Scope = "/subscriptions/<sub-id>/resourceGroups/<rg-name-1>" },
    @{ ObjectId = "<object-id-1>"; Role = "<Role 2>"; Scope = "/subscriptions/<sub-id>/resourceGroups/<rg-name-2>" },
    @{ ObjectId = "<object-id-2>"; Role = "<Role 3>"; Scope = "/subscriptions/<sub-id>/resourceGroups/<rg-name-3>" },
    @{ ObjectId = "<object-id-3>"; Role = "<Role 4>"; Scope = "/subscriptions/<sub-id>/resourceGroups/<rg-name-4>" }
)

foreach ($assignment in $assignments) {
    try {
        New-AzRoleAssignment -ObjectId $assignment.ObjectId `
                             -RoleDefinitionName $assignment.Role `
                             -Scope $assignment.Scope
        Write-Host "Assigned role '$($assignment.Role)' to object '$($assignment.ObjectId)' on scope '$($assignment.Scope)'"
    } 
    catch {
        Write-Warning "Failed to assign role '$($assignment.Role)' to object '$($assignment.ObjectId)' on scope '$($assignment.Scope)': $_"
    }
}
