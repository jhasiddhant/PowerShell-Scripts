$tenantID = "<Tenant ID>"                         # Enter your tenant ID
$subscriptionID = "<subscription ID>"             # Enter your subscription ID
$scope = "/subscriptions/subscriptionID"          # Enter the scope of the role assignment

Connect-AzAccount -Subscription $subscriptionID

# Set the output CSV file path
$outputPath = "<your-desired-path>\PIM.csv"

# Get PIM eligible assignments for the specified scope and export to CSV
Get-PimAzureResourceEligibleAssignment -TenantId $tenantId -Scope $scope -Summary |
    Export-Csv -Path $outputPath -NoTypeInformation