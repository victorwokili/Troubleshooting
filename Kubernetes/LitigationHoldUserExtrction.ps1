#Script to extract Litigation Hold User Information
# Step 1: Check the current execution policy and store the original value
$originalExecutionPolicy = Get-ExecutionPolicy

if ($originalExecutionPolicy -eq "Restricted") {
    # Step 2: Temporarily set the execution policy to RemoteSigned for this process
    Set-ExecutionPolicy RemoteSigned -Scope Process -Force
    Write-Host "Execution policy set to RemoteSigned for this process."
} else {
    Write-Host "Current execution policy is: $originalExecutionPolicy. No changes needed."
}

# Step 3: Install PowerShellGet module if not installed
$moduleName = "PowerShellGet"
if (-not (Get-Module -ListAvailable -Name $moduleName)) {
    Write-Host "PowerShellGet module not found. Installing..."
    Install-Module -Name PowerShellGet -Force -AllowClobber -Scope CurrentUser
    Write-Host "PowerShellGet module installed successfully."
} else {
    Write-Host "PowerShellGet module is already installed."
}

# Step 4: Install ExchangeOnlineManagement module
$moduleName = "ExchangeOnlineManagement"
if (-not (Get-Module -ListAvailable -Name $moduleName)) {
    Write-Host "ExchangeOnlineManagement module not found. Installing..."
    Install-Module -Name ExchangeOnlineManagement -Force -AllowClobber -Scope CurrentUser

    # Handle untrusted repository warning
    $untrustedRepoResponse = Read-Host "Are you sure you want to install modules from 'PSGallery'? [Y/N]"
    if ($untrustedRepoResponse -eq 'Y') {
        Write-Host "Installing modules from PSGallery..."
    } else {
        Write-Host "Installation aborted by user."
        exit
    }

    Write-Host "ExchangeOnlineManagement module installed successfully."
} else {
    Write-Host "ExchangeOnlineManagement module is already installed."
}

# Step 5: Get user credentials for Exchange Online
$UserCredential = Get-Credential
Connect-ExchangeOnline -UserPrincipalName $UserCredential.UserName -ShowProgress $true

# Step 6: Get the path to the user's Downloads folder
$downloadsPath = "$([Environment]::GetFolderPath('UserProfile'))\Downloads"

# Step 7: Get the list of users with Litigation Hold enabled
$litigationHoldUsers = Get-Mailbox -Filter {LitigationHoldEnabled -eq $true} -ResultSize Unlimited

# Check if any users were returned
if ($litigationHoldUsers.Count -eq 0) {
    Write-Host "No users with Litigation Hold enabled found."
    Disconnect-ExchangeOnline -Confirm:$false
    exit
}

# Create an empty array to store results
$results = @()

# Step 8: Loop through each user with Litigation Hold enabled
foreach ($user in $litigationHoldUsers) {
    Write-Host "Processing user: $($user.UserPrincipalName)"

    # Retrieve mailbox details including LitigationHoldEnabled and LitigationHoldDate
    $mailboxDetails = Get-Mailbox -Identity $user.UserPrincipalName
    
    # Get details related to the hold creation from Get-Mailbox
    $litigationHoldDate = $mailboxDetails.LitigationHoldDate
    $holdStartedBy = $mailboxDetails.HoldOwner # HoldOwner retrieves the person who started the hold (if available)

    # Log the litigation hold details for the user
    Write-Host "Litigation Hold Date for $($user.UserPrincipalName): $litigationHoldDate"
    Write-Host "Hold Started By for $($user.UserPrincipalName): $holdStartedBy"

    # If litigation hold is enabled and the date is available, store the result
    if ($mailboxDetails.LitigationHoldEnabled -and $litigationHoldDate) {
        $results += [pscustomobject]@{
            User                 = $user.UserPrincipalName
            DisplayName          = $user.DisplayName
            LitigationHoldEnabled = $mailboxDetails.LitigationHoldEnabled
            LitigationHoldDate   = $litigationHoldDate
            HoldStartedBy        = $holdStartedBy
        }
    } else {
        Write-Host "No litigation hold date found for $($user.UserPrincipalName)"
    }
}

# Step 9: Check if results are empty before exporting
if ($results.Count -eq 0) {
    Write-Host "No data to export. No users with valid litigation hold date found."
} else {
    # Output the results to a CSV file in the Downloads folder
    $csvFilePath = "$downloadsPath\LitigationHoldUsersWithDetails.csv"
    $results | Export-Csv -Path $csvFilePath -NoTypeInformation
    Write-Host "Results exported to: $csvFilePath"
}

# Step 10: Disconnect the Exchange Online session
Disconnect-ExchangeOnline -Confirm:$false
Write-Host "Disconnected from Exchange Online."

# Step 11: Revert the execution policy back to the original policy
if ($originalExecutionPolicy -eq "Restricted") {
    Set-ExecutionPolicy Restricted -Scope Process -Force
    Write-Host "Execution policy reverted back to Restricted."
} else {
    Write-Host "No need to revert the execution policy."
}
