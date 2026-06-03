# Synopsis:
# Verify that each exercise's example/exemplar solution passes the tests
# using the track's test runner Docker image.
# You can either verify all exercises or a single exercise.

# Example: verify all exercises in Docker
# .\bin\verify-exercises-in-docker.ps1

# Example: verify single exercise in Docker
# .\bin\verify-exercises-in-docker.ps1 two-fer

# Example: verify all exercises against specified test runner
# .\bin\verify-exercises-in-docker.ps1 -Image my-local-image

param(
    [Parameter(Position=0, ValueFromRemainingArguments)]
    [string[]]$Slugs,
    [string]$Image = ""
)

$ErrorActionPreference = "Stop"

Function Test-RequiredTool([string]$Name) {
    if (-not (Get-Command $Name -ErrorAction SilentlyContinue)) {
        Write-Error "${Name} is required but not installed. Please install it and make sure it's in your PATH."
    }
}

Function Copy-ReferenceSolution([string]$Dir) {
    $config = Get-Content (Join-Path $Dir ".meta" "config.json") | ConvertFrom-Json
    $solutions = @($config.files.solution)
    $sources = @(if ($config.files.exemplar) { $config.files.exemplar } else { $config.files.example })
    for ($i = 0; $i -lt $solutions.Count; $i++) {
        $dst = Join-Path $Dir $solutions[$i]
        $src = Join-Path $Dir $sources[$i]
        Copy-Item -Path $src -Destination $dst -Force
    }
}

Function Invoke-Tests([string]$Slug, [string]$Dir) {
    $dockerArgs = @(
        "run", "--rm", "--network", "none",
        "--mount", "type=bind,src=${Dir},dst=/solution",
        "--mount", "type=volume,dst=/tmp",
        $Image, $Slug, "/solution", "/solution"
    )
    docker @dockerArgs | Out-Null
    $resultsPath = Join-Path $Dir "results.json"
    $results = Get-Content $resultsPath | ConvertFrom-Json
    return $results.status -eq "pass"
}

Function Test-Exercise([string]$ExerciseDir) {
    $dir = (Resolve-Path $ExerciseDir).Path
    $slug = Split-Path $dir -Leaf
    $tmpDir = Join-Path ([System.IO.Path]::GetTempPath()) "exercism-verify-${slug}-$([System.IO.Path]::GetRandomFileName())"
    New-Item -ItemType Directory -Path $tmpDir | Out-Null

    Write-Host "Verifying ${slug} exercise..."
    try {
        Copy-Item -Path (Join-Path $dir "*") -Destination $tmpDir -Recurse -Force
        Copy-ReferenceSolution $tmpDir
        $passed = Invoke-Tests $slug $tmpDir
        if (-not $passed) {
            Get-Content (Join-Path $tmpDir "results.json") | Write-Host
            return $false
        }
        return $true
    }
    finally {
        Remove-Item -Path $tmpDir -Recurse -Force -ErrorAction SilentlyContinue
    }
}

# Main

Test-RequiredTool "docker"
Test-RequiredTool "jq"

if (-not $Image) {
    $Image = "exercism/racket-test-runner"
    docker pull $Image
    if ($LASTEXITCODE -ne 0) {
        Write-Error "docker pull ${Image} failed. Check the test runner docs at https://exercism.org/docs/building/tooling/test-runners for more information."
    }
}

$exercises = @()
if ($Slugs.Count -gt 0) {
    foreach ($slug in $Slugs) {
        foreach ($parent in "concept", "practice") {
            $path = Join-Path "." "exercises" $parent $slug
            if (Test-Path $path -PathType Container) {
                $exercises += $path
            }
        }
    }
}
else {
    foreach ($parent in "concept", "practice") {
        $parentDir = Join-Path "." "exercises" $parent
        if (Test-Path $parentDir -PathType Container) {
            $exercises += Get-ChildItem -Path $parentDir -Directory | ForEach-Object { $_.FullName }
        }
    }
}

if ($exercises.Count -eq 0) {
    Write-Error "No matching exercises found"
}

$rc = 0
foreach ($exerciseDir in $exercises) {
    $passed = Test-Exercise $exerciseDir
    if (-not $passed) { $rc = 1 }
}
exit $rc
