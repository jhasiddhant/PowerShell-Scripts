Connect-AzAccount -Subscription "<Subscription Id>"

$token = (Get-AzAccessToken).Token
$url = "https://management.azure.com/subscriptions/<Subscription Id>/resourcegroups/<Resource Group Name>/providers/microsoft.automation/automationaccounts/<Automation Account Name>?api-version=2023-11-01"
$body = @{
    properties = @{
        disableLocalAuth = $true
    }
} | ConvertTo-Json

Invoke-RestMethod -Method Patch -Uri $url -Body $body -ContentType "application/json" -Headers @{ Authorization = "Bearer $token" }