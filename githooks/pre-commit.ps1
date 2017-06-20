# If you found this file in the .git folder, it will be overwritten next time you run setup.

Param(
)

Function ExplainUsername {
    Write-Host
    Write-Host "To set your username properly, write the following command:"
    Write-Host "git config --global user.name ""Firstname Lastname"""
    Write-Host
    Write-Host "Your name should match exactly how it appears in the Active Directory."
}

Function ExplainEmail {
    Write-Host
    Write-Host "To set your e-mail properly, write the following command:"
    Write-Host "git config --global user.email ""alias@microsoft.com"""
    Write-Host
    Write-Host "The e-mail must consist of your *alias* and end with *microsoft.com*"
}

$shouldExplainUsername = $false
$shouldExplainEmail = $false
$username = Invoke-Expression -Command "git config --get user.name"
$email = Invoke-Expression -Command "git config --get user.email"
$gitroot = (Invoke-Expression -Command "git rev-parse --show-toplevel").Replace("/","\")

if (!$username) {
    $username = ""
}

if (!$email) {
    $email = ""
}

# Check for username
if (!$username.Contains(" ")) {
    Write-Warning "Your name must contain a space."
    $shouldExplainUsername = $true
}

if ($username[0].ToString() -cne $username[0].ToString().ToUpper()) {
    Write-Warning "Your name must start with a capital letter."
    $shouldExplainUsername = $true
}

# Check for e-mail
if (!$email.EndsWith("microsoft.com")) {
    Write-Warning "Your e-mail must end with microsoft.com"
    $shouldExplainEmail = $true
}

$emailSplit = $email.Split("@")
if ($emailSplit.Length -ne 2) {
    Write-Warning "Your e-mail doesn't seem to be formed properly."
}

$aliasSplit = $emailSplit[0].Split(".")
if ($aliasSplit.Length -ne 1) {
    Write-Warning "You must use your alias@microsoft.com as your e-mail. Not your easyId."
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