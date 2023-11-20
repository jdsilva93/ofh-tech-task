# Pass in own Azure specific details.
$tenantID = "< Azure Tenant ID >"
$dynamicGroupName = " < Azure Dynamic Group Name >"

# Install the AzureADPreview Powershell module as it is required to create the dynamic group.
Install-Module AzureADPreview

# Load the AzureADPreview module
Import-Module AzureADPreview

# Connecting to the Azure tenant AD / Entra ID.
Connect-AzureAD -TenantId $tenantID

# Create a group that dynamically adds users with an enabled account from the "Technology" Department.
New-AzureADMSGroup -DisplayName $dynamicGroupName `
-Description "This dynamic group encompasses active user accounts from the Technology Department." `
-MailEnabled $False `
-MailNickName "OFHDynGroup" `
-SecurityEnabled $True `
-GroupTypes "DynamicMembership" `
-MembershipRule '(user.Department -contains "Technology") and (user.accountEnabled -eq true)' `
-MembershipRuleProcessingState "On"
