# Upload TMW-contracts to GitHub
# Run this script from the project directory

Write-Host "Starting Git setup..." -ForegroundColor Cyan

# Get current directory
$currentDir = Get-Location
Write-Host "Current directory: $currentDir" -ForegroundColor Yellow

# Initialize git
Write-Host "`nInitializing Git repository..." -ForegroundColor Cyan
git init

if ($LASTEXITCODE -ne 0) {
    Write-Host "Error initializing Git!" -ForegroundColor Red
    exit 1
}

# Add all files
Write-Host "`nAdding files..." -ForegroundColor Cyan
git add .

if ($LASTEXITCODE -ne 0) {
    Write-Host "Error adding files!" -ForegroundColor Red
    exit 1
}

# Commit
Write-Host "`nCreating commit..." -ForegroundColor Cyan
git commit -m "Initial commit: TMW Vehicle Sale Contract

- Редизайн на kzo_contract за QBCore
- Добавена система за цени при продажба
- Минималистичен футуристичен UI с TMW брандинг
- Прогресбар система при подписване
- Градиентни рамки и анимации
- Превод на български език
- Debug режим за разработчици"

if ($LASTEXITCODE -ne 0) {
    Write-Host "Error creating commit!" -ForegroundColor Red
    exit 1
}

# Add remote
Write-Host "`nAdding remote origin..." -ForegroundColor Cyan
git remote add origin https://github.com/Sureebi/TMW-contracts.git

if ($LASTEXITCODE -ne 0) {
    Write-Host "Remote might already exist, continuing..." -ForegroundColor Yellow
}

# Rename branch to main
Write-Host "`nRenaming branch to main..." -ForegroundColor Cyan
git branch -M main

if ($LASTEXITCODE -ne 0) {
    Write-Host "Error renaming branch!" -ForegroundColor Red
    exit 1
}

# Push to GitHub
Write-Host "`nPushing to GitHub..." -ForegroundColor Cyan
git push -u origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host "`n✅ Successfully uploaded to GitHub!" -ForegroundColor Green
    Write-Host "`nRepository URL: https://github.com/Sureebi/TMW-contracts" -ForegroundColor Cyan
    Write-Host "`nNext steps:" -ForegroundColor Yellow
    Write-Host "1. Visit the repository on GitHub"
    Write-Host "2. Add topics: qbcore, fivem, vehicle-sale, lua, contract"
    Write-Host "3. Check that preview.png is displayed in README"
    Write-Host "4. Share with the community!"
} else {
    Write-Host "`n❌ Error pushing to GitHub!" -ForegroundColor Red
    Write-Host "Please check your GitHub credentials and try again." -ForegroundColor Yellow
}

Write-Host "`nPress any key to exit..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
