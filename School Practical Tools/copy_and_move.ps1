# Define the location of the user list CSV file
$csvPath = "E:\userlist\users.csv"

# Define the destination root folder
$destinationRoot = "D:\Usersfiles"

# Define the folder to copy to each user's Desktop
$sourceFolderToCopy = "E:\FolderToCopy"

# Import the list of users from the CSV file
# Ensure the CSV has a column named 'Username'
if (-Not (Test-Path $csvPath)) {
    Write-Error "The specified CSV file '$csvPath' does not exist."
    exit
}

# Check if the folder to copy exists
if (-Not (Test-Path $sourceFolderToCopy)) {
    Write-Error "The source folder '$sourceFolderToCopy' does not exist."
    exit
}

# Read user data
$users = Import-Csv -Path $csvPath

foreach ($user in $users) {
    # Get the username from the CSV
    $username = $user.Username

    # Define source folders
    $desktopSource = "C:\Users\$username\Desktop"
    $documentsSource = "C:\Users\$username\Documents"

    # Define destination folder
    $userDestination = Join-Path $destinationRoot $username

    # Create the destination folder if it doesn't exist
    if (-Not (Test-Path $userDestination)) {
        New-Item -ItemType Directory -Path $userDestination | Out-Null
    }

    # Copy Desktop files if source exists
    if (Test-Path $desktopSource) {
        $desktopDestination = Join-Path $userDestination "Desktop"
        if (-Not (Test-Path $desktopDestination)) {
            New-Item -ItemType Directory -Path $desktopDestination | Out-Null
        }
        Copy-Item -Path $desktopSource\* -Destination $desktopDestination -Recurse -Force -ErrorAction SilentlyContinue
    } else {
        Write-Host "Desktop folder does not exist for user: $username" -ForegroundColor Yellow
    }

    # Copy Documents files if source exists
    if (Test-Path $documentsSource) {
        $documentsDestination = Join-Path $userDestination "Documents"
        if (-Not (Test-Path $documentsDestination)) {
            New-Item -ItemType Directory -Path $documentsDestination | Out-Null
        }
        Copy-Item -Path $documentsSource\* -Destination $documentsDestination -Recurse -Force -ErrorAction SilentlyContinue
    } else {
        Write-Host "Documents folder does not exist for user: $username" -ForegroundColor Yellow
    }

    # Copy the specified folder to the user's Desktop
    if (Test-Path $desktopSource) {
        $desktopTarget = Join-Path $desktopSource (Split-Path -Leaf $sourceFolderToCopy)
        if (-Not (Test-Path $desktopTarget)) {
            Copy-Item -Path $sourceFolderToCopy -Destination $desktopTarget -Recurse -Force -ErrorAction SilentlyContinue
            Write-Host "Copied '$sourceFolderToCopy' to $username's Desktop." -ForegroundColor Green
        } else {
            Write-Host "Folder '$sourceFolderToCopy' already exists on $username's Desktop. Skipping..." -ForegroundColor Yellow
        }
    } else {
        Write-Host "Cannot copy folder to $username's Desktop because it does not exist." -ForegroundColor Red
    }
}

Write-Host "Script execution completed." -ForegroundColor Cyan
