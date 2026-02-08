# 📤 Качване на TMW-contracts в GitHub

## Стъпка 1: Инициализиране на Git
Отворете PowerShell в папката на проекта и изпълнете:

```powershell
.\git-setup.ps1
```

Или ръчно:
```powershell
git init
git add .
git commit -m "Initial commit: TMW Vehicle Sale Contract"
```

## Стъпка 2: Създаване на GitHub репозитория

1. Отидете на https://github.com/new
2. Repository name: `TMW-contracts`
3. Description: `Редизайн на kzo_contract за QBCore с добавена цена при продажба на автомобил`
4. Изберете Public или Private
5. **НЕ** добавяйте README, .gitignore или license (вече ги имаме)
6. Натиснете "Create repository"

## Стъпка 3: Свързване и качване

Копирайте командите от GitHub и изпълнете:

```powershell
git remote add origin https://github.com/YOUR_USERNAME/TMW-contracts.git
git branch -M main
git push -u origin main
```

Заменете `YOUR_USERNAME` с вашето GitHub потребителско име.

## Стъпка 4: Добавяне на preview изображение

GitHub автоматично ще покаже `preview.png` в README.md файла.

## 🎉 Готово!

Вашият проект е качен в GitHub!

### Следващи стъпки:
- Добавете topics в GitHub: `qbcore`, `fivem`, `vehicle-sale`, `lua`
- Добавете GitHub Pages за документация (опционално)
- Споделете линка с общността

## 📝 Бъдещи промени

За да качите промени:
```powershell
git add .
git commit -m "Описание на промените"
git push
```

## 🔄 Клониране на друг компютър

```powershell
git clone https://github.com/YOUR_USERNAME/TMW-contracts.git
```
