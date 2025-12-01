# Weekly Cartoon Update Script
# Usage: .\update-cartoon.ps1

$weekNumber = Get-Date -UFormat %V
$year = Get-Date -UFormat %Y
$cartoonFile = "2025-W$weekNumber.png"
$sourceImage = ".\new-cartoon.png"  # Your new cartoon file
$targetPath = ".\static\images\cartoons\$cartoonFile"

# Check if new cartoon exists
if (Test-Path $sourceImage) {
    # Copy to cartoons folder with week number
    Copy-Item $sourceImage $targetPath
    
    # Update the 'latest' symlink
    Copy-Item $sourceImage ".\static\images\cartoons\latest.png" -Force
    
    # Add to git
    git add static\images\cartoons\$cartoonFile
    git add static\images\cartoons\latest.png
    
    Write-Host "Cartoon updated for Week $weekNumber"
    Write-Host "File: $cartoonFile"
    Write-Host ""
    Write-Host "Next steps:"
    Write-Host "1. Update content\cartoon\_index.md with new entry"
    Write-Host "2. Run: git commit -m 'Add cartoon for week $weekNumber'"
    Write-Host "3. Run: git push origin main"
} else {
    Write-Host "Error: new-cartoon.png not found"
    Write-Host "Place your new cartoon as 'new-cartoon.png' in the root directory"
}