param(
    [string]$subscriptionid
)

$ClientSecret = "SERVICE_PRINCIPAL_SECRET"
$ApplicationID = "SERVICE_PRINCIPAL_ID"
$TenantID = "TENANT"


#use service principal to connect Azure Account 
$passwd = ConvertTo-SecureString $ClientSecret -AsPlainText -Force
$pscredential = New-Object System.Management.Automation.PSCredential($ApplicationID, $passwd)
Connect-AzAccount -Credential $pscredential -Tenant $TenantID -ServicePrincipal
Set-AzContext -Subscription $subscriptionid

$policyDefinitionName = "Deploy-VM-Backup"
$policyAssignmentName = "Deploy-VM-Backup-Assignment"
$assignmentScope = "/subscriptions/${subscriptionid}"
$enforcementMode = "Default"
$parameters = @{
    vaultLocation = "westeurope"
    backupPolicyId = "/subscriptions/${subscriptionid}/resourceGroups/backup-rg/providers/Microsoft.RecoveryServices/vaults/rsv-Backup/backupPolicies/BackupPolicy"
    exclusionTagName = ""
    exclusionTagValue = @()
    effect = "deployIfNotExists"
}

$policyDefinition = Get-AzPolicyDefinition | Where-Object { $_.Properties.DisplayName -eq $policyDefinitionName }
New-AzPolicyAssignment -Name $policyAssignmentName -Location "westeurope" -PolicyDefinition $policyDefinition -Scope $assignmentScope -EnforcementMode $enforcementMode -PolicyParameterObject $parameters -IdentityType "SystemAssigned"

$assignmentID = "/subscriptions/${subscriptionid}/providers/microsoft.authorization/policyassignments/deploy-vm-backup-assignment"

$metadata = @{
    parameterScopes = @{
        backupPolicyId = "/subscriptions/${subscriptionid}/resourcegroups/backup-rg/providers/microsoft.recoveryservices/vaults/rsv-backup/backupPolicies/BackupPolicy"
    }
} | ConvertTo-Json

Set-AzPolicyAssignment -Id $assignmentID -Metadata $metadata