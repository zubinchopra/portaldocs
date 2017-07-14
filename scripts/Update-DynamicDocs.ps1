<#
.SYNOPSIS
    Switches to the production_SDK branch, generates dynamicdocs only, and publishes them to the master_template and master folders
#>
$ErrorActionPreference = "Stop"
Set-StrictMode -Version 2.0

$branch = "production_sdk"
$docMasterTemplateBranch = "master_template" # the master branch that contains the template files and generated files
$docMasterGeneratedBranch = "master" # the master branch that only contains generated files.  This is separated so that when users are searching github, they don't get results from template files.

$userName = $env:userName
$userEmail = $env:userEmail

$githubPortalDocsUser = $env:githubPortalDocsUser
$githubPortalDocsPass = $env:githubPortalDocsPass

if (!$userName)
{
    Write-Error "A user name must be provided via the 'userName' environment variable.  This name will appear on commits made to the portaldocs repo"
}

if (!$userEmail)
{
    Write-Error "A user email must be provided via the 'userEmail' environment variable.  This email will appear on commits made to the portaldocs repo"
}

if (!$githubPortalDocsUser)
{
    Write-Error "A github account user name must be provided via the 'githubPortalDocsUser' environment variable.  The account must have access to the portaldocs github repo."
}

if (!$githubPortalDocsPass)
{
    Write-Error "A github account password/access key must be provided via the 'githubPortalDocsPass' environment variable.   The account must have access to the portaldocs github repo."
}

if (!$env:AZURE_STORAGE_CONNECTION_STRING)
{
    Write-Error "The environment variable  'AZURE_STORAGE_CONNECTION_STRING' must be provided for dynamic docs to be generated"
}

Write-Host "Generating git credentials file..."
$credentialsFile = Join-Path $env:USERPROFILE ".git-credentials"
$env:gitcredentials + "`n" | Out-File $credentialsFile -Encoding ascii
"https://$($githubPortalDocsUser):$($githubPortalDocsPass)@github.com" + "`n" | Out-File $credentialsFile -Encoding ascii

try {
    Set-Location -Path $Env:WORKSPACE

    Write-Host "Configuring user..."
    git config --local user.name "Ibiza Automation Account"
    git config --local user.email ibizaatm@microsoft.com
    git config --local credential.helper store

    Write-Host "Discarding any changes (might block checkout)..."
    git checkout .
    # Done twice because that's needed to discard line ending conflicts
    git checkout .

    if ($LASTEXITCODE -ne 0) {
        throw "git checkout failed with exit code $LASTEXITCODE"
    }

    Write-Host "branches..."
    git branch --list
    Write-Host "status..."
    git status

    Write-Host "Checking out $branch branch..."

    &cmd /C "git checkout $branch 2>&1"

    if ($LASTEXITCODE -ne 0) {
        throw "git checkout $branch failed with exit code $LASTEXITCODE"
    }

    git status

    Write-Host "Forcing to latest..."
    &cmd /C "git reset --hard origin/$branch 2>&1"

    if ($LASTEXITCODE -ne 0) {
        throw "git reset failed with exit code $LASTEXITCODE"
    }

    # init the doc submodule.
    &cmd /C "git submodule update --init 2>&1"
    &cmd /C "git status 2>&1"
    $docPath = $Env:WORKSPACE + "\doc"
    Set-Location -Path $docPath

    # ibizaatm doesn't have access to portaldocs in github so have to use a different user
    git config --local user.name "$userName"
    git config --local user.email "$userEmail"
    git config --local credential.helper store
    git config --local push.default simple

    # switch to master_template branch in docs
    &cmd /C "git checkout $docMasterTemplateBranch 2>&1"
    &cmd /C "git reset --hard origin/$docMasterTemplateBranch 2>&1"

    if ($LASTEXITCODE -ne 0) {
        throw "git reset failed with exit code $LASTEXITCODE"
    }

    # generate the documents   
    npm install --no-optional

    # generate dynamic docs downloads, breaking changes, release notes
    # this requires AZURE_STORAGE_CONNECTION_STRING to be set to auxwebofficialbuilds storage account connection string as environmental var
    npm run dynamicdocs  

    # stage the files in case there are only new line changes
    &cmd /C "git add . 2>&1"

    Write-Host "git status after doc generation" 
    $gitstatus = git status --porcelain
    Write-Host $gitstatus

    # Push if there are any new generated docs
    if ($gitstatus) {
        # Commit merge (any unresolved merge conflicts should fail here)
        git commit -m "[Automated] Update generated docs release notes and breaking changes in $docMasterTemplateBranch branch" --no-verify
        if ($LASTEXITCODE -ne 0) {
            throw "git commit failed during update of generated docs in $docMasterTemplateBranch branch with exit code $LASTEXITCODE.  Please fix any conflicts manually."
        }

        # Push doc changes
        git push origin $docMasterTemplateBranch
        if ($LASTEXITCODE -ne 0) {
            throw "git push failed during update of generated docs in $docMasterTemplateBranch branch with exit code $LASTEXITCODE."
        }
        git status
        Write-Host "merge to $docMasterTemplateBranch done."

        # Checkout the master generated branch
        &cmd /C "git checkout $docMasterGeneratedBranch 2>&1"
        &cmd /C "git reset --hard origin/$docMasterGeneratedBranch 2>&1"

        # Merge the generated files into the master branch
        &cmd /C "git merge --no-commit -X theirs $docMasterTemplateBranch 2>&1"

        # Don't merge template files into master_generated
        Write-Host "Undoing changes in template folders"
        &cmd /C "git clean -xdf portal-sdk/templates"

        &cmd /C "git reset gallery-sdk/templates/"
        &cmd /C "git checkout -- gallery-sdk/templates"
        &cmd /C "git clean -xdf gallery-sdk/templates"

        Write-Host "The following files will be merged: 2>&1"
        &cmd /C "git status"

        &cmd /C "git add . 2>&1"

        # Force add generated files since they would be ignored otherwise via the .gitignore file
        &cmd /C "git add gallery-sdk/generated -f 2>&1"
        &cmd /C "git add portal-sdk/generated -f 2>&1"

        # Commit merge (any unresolved merge conflicts should fail here)
        git commit -m "[Automated] Merge generated docs release notes and breaking changes from $docMasterTemplateBranch branch into $docMasterGeneratedBranch branch." --no-verify
        if ($LASTEXITCODE -ne 0) {
            throw "git commit failed during merge from $docMasterTemplateBranch branch into $docMasterGeneratedBranch branch with exit code $LASTEXITCODE.  Please fix any conflicts manually."
        }

        # push doc changes to master branch
        git push origin $docMasterGeneratedBranch
        if ($LASTEXITCODE -ne 0) {
            throw "git push failed during merge from $docMasterTemplateBranch branch into $docMasterGeneratedBranch branch with exit code $LASTEXITCODE."
        }
        git status
        Write-Host "merge to $docMasterGeneratedBranch done."
    } 
    else {
        throw "not in /doc"
    }
    Write-Host "merge done."
}
finally {
    Write-Host "Deleting $credentialsFile"
    Remove-Item $credentialsFile -Force
    git config --local --unset credential.helper
    git config --local --unset user.name
    git config --local --unset user.email
}