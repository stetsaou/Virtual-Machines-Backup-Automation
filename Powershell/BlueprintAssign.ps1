param(
    [string]$subscriptionid,
    [string]$businessCriticality
)

Install-Module -Name Az.Blueprint -Force
Import-Module Az.Blueprint
az extension add --name blueprint

if ($businessCriticality -eq "Low") {
    $blueprintName = "PPC-Low-Criticality"
    $rg = @{ResourceGroup=@{name='backup-rg';location='LOCATION'}}
    $params = @{LowCritPolicy_vaultName="rsv-Backup"; LowCritPolicy_skuTier="Standard"; LowCritPolicy_policyName="BackupPolicy"; rsv_vaultName="rsv-Backup"; rsv_vaultStorageType="GeoRedundant"; rsv_location="LOCATION"; rsv_enableCRR= $true}
    $blueprintObject =  Get-AzBlueprint -ManagementGroupId 'MG' -Name $blueprintName
    New-AzBlueprintAssignment -Name "myAssignment" -Blueprint $blueprintObject -SubscriptionId $subscriptionid -Location "LOCATION" -ResourceGroupParameter $rg -Parameter $params
} elseif ($businessCriticality -eq "Medium") {
    $blueprintName="PPC-Medium-Criticality"
    $rg = @{ResourceGroup=@{name='backup-rg';location='LOCATION'}}
    $params = @{MedCritPolicy_vaultName="rsv-Backup"; MedCritPolicy_skuTier="Standard"; MedCritPolicy_policyName="BackupPolicy"; rsv_vaultName="rsv-Backup"; rsv_vaultStorageType="GeoRedundant"; rsv_location="LOCATION"; rsv_enableCRR= $true}
    $blueprintObject =  Get-AzBlueprint -ManagementGroupId 'MG' -Name $blueprintName
    New-AzBlueprintAssignment -Name "myAssignment" -Blueprint $blueprintObject -SubscriptionId $subscriptionid -Location "LOCATION" -ResourceGroupParameter $rg -Parameter $params
} elseif ($businessCriticality -eq "High") {
    $blueprintName="PPC-High-Criticality"
    $rg = @{ResourceGroup=@{name='backup-rg';location='LOCATION'}}
    $params = @{HighCritPolicy_vaultName="rsv-Backup"; HighCritPolicy_skuTier="Standard"; HighCritPolicy_policyName="BackupPolicy"; rsv_vaultName="rsv-Backup"; rsv_vaultStorageType="GeoRedundant"; rsv_location="LOCATION"; rsv_enableCRR= $true}
    $blueprintObject =  Get-AzBlueprint -ManagementGroupId 'MG' -Name $blueprintName
    New-AzBlueprintAssignment -Name "myAssignment" -Blueprint $blueprintObject -SubscriptionId $subscriptionid -Location "LOCATION" -ResourceGroupParameter $rg -Parameter $params
} elseif ($businessCriticality -eq "Critical") {
    $blueprintName="PPC-Critical-Criticality"
    $rg = @{ResourceGroup=@{name='backup-rg';location='LOCATION'}}
    $params = @{CritPolicy_vaultName="rsv-Backup"; CritPolicy_skuTier="Standard"; CritPolicy_policyName="BackupPolicy"; rsv_vaultName="rsv-Backup"; rsv_vaultStorageType="GeoRedundant"; rsv_location="LOCATION"; rsv_enableCRR= $true}
    $blueprintObject =  Get-AzBlueprint -ManagementGroupId 'MG' -Name $blueprintName
    New-AzBlueprintAssignment -Name "myAssignment" -Blueprint $blueprintObject -SubscriptionId $subscriptionid -Location "LOCATION" -ResourceGroupParameter $rg -Parameter $params
} else {
    Write-Error "Invalid business criticality tag value"
    exit 1
}