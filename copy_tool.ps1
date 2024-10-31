# Retrieve all users in the "Remote Desktop Users" group
$RemoteDesktopUsers = Get-LocalGroupMember -Group "Remote Desktop Users" | Where-Object { $_.ObjectClass -eq 'User' }

# Source folder path
$SourceFolder = "C:\Users\myuser\Documents"

# Loop through each Remote Desktop user
foreach ($User in $RemoteDesktopUsers) {
    # Destination folder path
    $DestinationFolder = "C:\Users\$($User.Name)\Desktop"

    # Check if the destination path exists
    if (Test-Path -Path $DestinationFolder) {
        # Copy the folder and its contents
        Copy-Item -Path $SourceFolder -Destination $DestinationFolder -Recurse -Force
    } else {
        Write-Output "Desktop path for $($User.Name) does not exist."
    }
}
