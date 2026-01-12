# Bulk AD User Creation Script
# Author: Owen
# Lab environment only
# Purpose: Automate creation of AD users from CSV

# Import the Active Directory module
Import-Module ActiveDirectory

# Define the path to your CSV file
$CSVPath = ".\users.csv"

# Import the CSV
$Users = Import-Csv -Path $CSVPath

# Loop through each user in the CSV
foreach ($User in $Users) {

    # Extract info from CSV
    $FirstName = $User.FirstName
    $LastName = $User.LastName
    $Username = $User.Username
    $OU = $User.OU
    $Group = $User.Group
    $Password = "P@ssw0rd123!"  # Example password for lab; never use in production

    # Check if user already exists
    if (Get-ADUser -Filter {SamAccountName -eq $Username} -ErrorAction SilentlyContinue) {
        Write-Host "User $Username already exists. Skipping."
    }
    else {
        Try {
            # Create the new AD user
            New-ADUser `
                -Name "$FirstName $LastName" `
                -GivenName $FirstName `
                -Surname $LastName `
                -SamAccountName $Username `
                -UserPrincipalName "$Username@lab.local" `
                -Path $OU `
                -AccountPassword (ConvertTo-SecureString $Password -AsPlainText -Force) `
                -Enabled $true

            # Add the user to the specified group
            Add-ADGroupMember -Identity $Group -Members $Username

            Write-Host "User $Username created and added to $Group successfully."
        }
        Catch {
            Write-Host "Failed to create user $Username. Error: $_"
        }
    }
}
