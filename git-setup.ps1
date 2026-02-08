# Git Setup Script for TMW-contracts

# Initialize git repository
git init

# Add all files
git add .

# Create initial commit
git commit -m "Initial commit: TMW Vehicle Sale Contract

- Редизайн на kzo_contract за QBCore
- Добавена система за цени при продажба
- Минималистичен футуристичен UI с TMW брандинг
- Прогресбар система при подписване
- Градиентни рамки и анимации
- Превод на български език
- Debug режим за разработчици"

# Instructions for adding remote
Write-Host ""
Write-Host "Git repository initialized successfully!" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "1. Create a new repository on GitHub named 'TMW-contracts'"
Write-Host "2. Run these commands:"
Write-Host ""
Write-Host "   git remote add origin https://github.com/YOUR_USERNAME/TMW-contracts.git" -ForegroundColor Cyan
Write-Host "   git branch -M main" -ForegroundColor Cyan
Write-Host "   git push -u origin main" -ForegroundColor Cyan
Write-Host ""
