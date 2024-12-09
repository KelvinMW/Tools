# Define the location of the user list CSV file
$csvPath = "E:\userlist\users.csv"

# Define the destination root folder
$destinationRoot = "D:\Usersfiles"

# Import the list of users from the CSV file
if (-Not (Test-Path $csvPath)) {
    Write-Error "The specified CSV file '$csvPath' does not exist."
    exit
}

# Read user data from the CSV
$users = Import-Csv -Path $csvPath

foreach ($user in $users) {
    # Extract the 'Username' and 'Name' from the CSV
    $username = $user.Username
    $userName = $user.Name

    # Define the source folder (Desktop)
    $desktopSource = "C:\Users\$username\Desktop"

    # Define the destination folder using 'Name'
    $userDestination = Join-Path $destinationRoot $userName

    # Create the destination folder if it doesn't exist
    if (-Not (Test-Path $userDestination)) {
        New-Item -ItemType Directory -Path $userDestination | Out-Null
    }

    # Copy files from Desktop if the source exists
    if (Test-Path $desktopSource) {
        Copy-Item -Path $desktopSource\* -Destination $userDestination -Recurse -Force -ErrorAction SilentlyContinue
        Write-Host "Files from '$username's Desktop copied to '$userName' folder." -ForegroundColor Green
    } else {
        Write-Host "Desktop folder does not exist for user: $username" -ForegroundColor Yellow
    }
}

Write-Host "Script execution completed." -ForegroundColor Cyan
