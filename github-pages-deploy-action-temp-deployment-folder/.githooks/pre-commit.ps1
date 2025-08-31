param(
    [Parameter(ValueFromRemainingArguments=$true)]
    $Args
)

Write-Host "[pre-commit.ps1] scanning staged files for secrets..."

$pattern = 'github_pat_|GITHUB_TOKEN|PRIVATE[_-]?KEY|-----BEGIN PRIVATE KEY-----|aws_access_key_id|aws_secret_access_key|AKIA[0-9A-Z]{16}'

# Get list of staged files
$staged = git diff --cached --name-only
if (-not $staged) {
    Write-Host "No staged files."; exit 0
}

$found = $false
foreach ($file in $staged) {
    try {
        $content = git show :"$file" 2>$null
    } catch {
        $content = ""
    }
    if ($content -match $pattern) {
        Write-Error "Potential secret detected in staged file: $file"
        $content -split "`n" | Select-String -Pattern $pattern | ForEach-Object { Write-Error "$_" }
        $found = $true
    }
}

if ($found) {
    Write-Error "Aborting commit. Remove secrets from staged files or reset them before committing."
    exit 1
}

Write-Host "[pre-commit.ps1] no obvious secrets found. Proceeding."
exit 0
