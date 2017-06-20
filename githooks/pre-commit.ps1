# If you found this file in the .git folder, it will be overwritten next time you run setup.

Param(
)

Function ExplainUsername {
    Write-Host
    Write-Host "To set your username properly, write the following command:"
    Write-Host "git config --global user.name ""Firstname Lastname"""
    Write-Host
}

Function ExplainEmail {
    Write-Host
    Write-Host "To set your e-mail properly, write the following command:"
    Write-Host "git config --global user.email ""alias@domain.com"""
    Write-Host
}

$shouldExplainUsername = $false
$shouldExplainEmail = $false
$username = Invoke-Expression -Command "git config --get user.name"
$email = Invoke-Expression -Command "git config --get user.email"
$gitroot = (Invoke-Expression -Command "git rev-parse --show-toplevel").Replace("/","\")

# Check for username
if (!$username) {
    $shouldExplainUsername = $true
}

if (!$email) {
    $email = ""
}

# Check for e-mail
$emailSplit = $email.Split("@")
if ($emailSplit.Length -ne 2) {
    Write-Warning "Your e-mail doesn't seem to be formed properly."
}

# Warn the user and exit if required
if ($shouldExplainUsername -eq $true) {
    ExplainUsername
    exit 1
}

if ($shouldExplainEmail -eq $true) {
    ExplainEmail
    exit 1
}

# Run tests
pushd $gitroot
$npmInstallOutput = Invoke-Expression -Command "npm install --no-optional"
$npmRunDocOutput = Invoke-Expression -Command "npm run docs"

$brokenLinks = $npmRunDocOutput -match "Broken link/fragment found"
if ($brokenLinks -ne $null -and $brokenLinks.Count -gt 0) {
    Write-Warning "Broken links found.  Please fix them!"
    $brokenLinks | Write-Warning 
    exit 1
}