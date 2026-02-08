# 📤 Инструкции за качване в GitHub

## Метод 1: Автоматичен (Препоръчително)

### Стъпка 1: Отворете PowerShell
1. Натиснете `Shift + Right Click` в папката на проекта
2. Изберете "Open PowerShell window here" или "Open in Terminal"

### Стъпка 2: Изпълнете скрипта
```powershell
.\upload-to-github.ps1
```

Скриптът автоматично ще:
- ✅ Инициализира Git
- ✅ Добави всички файлове
- ✅ Създаде commit
- ✅ Свърже с GitHub
- ✅ Качи проекта

---

## Метод 2: Ръчен

### Стъпка 1: Отворете PowerShell в папката на проекта

### Стъпка 2: Изпълнете командите една по една

```powershell
# Инициализиране на Git
git init

# Добавяне на файлове
git add .

# Създаване на commit
git commit -m "Initial commit: TMW Vehicle Sale Contract"

# Добавяне на remote
git remote add origin https://github.com/Sureebi/TMW-contracts.git

# Преименуване на branch
git branch -M main

# Качване в GitHub
git push -u origin main
```

---

## Метод 3: GitHub Desktop (Най-лесен)

### Стъпка 1: Инсталирайте GitHub Desktop
Изтеглете от: https://desktop.github.com/

### Стъпка 2: Добавете проекта
1. Отворете GitHub Desktop
2. File → Add Local Repository
3. Изберете папката на проекта
4. Ако пита "Initialize Git", натиснете "Create Repository"

### Стъпка 3: Commit
1. Напишете commit message: "Initial commit: TMW Vehicle Sale Contract"
2. Натиснете "Commit to main"

### Стъпка 4: Publish
1. Натиснете "Publish repository"
2. Repository name: `TMW-contracts`
3. Description: `Редизайн на kzo_contract за QBCore с добавена цена при продажба на автомобил`
4. Махнете отметката от "Keep this code private" (ако искате public)
5. Натиснете "Publish Repository"

---

## 🔧 Troubleshooting

### Проблем: "Permission denied"
**Решение:** Уверете се че сте в правилната папка:
```powershell
cd "C:\path\to\TMW-contracts"
```

### Проблем: "Remote already exists"
**Решение:** Премахнете стария remote:
```powershell
git remote remove origin
git remote add origin https://github.com/Sureebi/TMW-contracts.git
```

### Проблем: "Authentication failed"
**Решение:** Използвайте Personal Access Token:
1. GitHub → Settings → Developer settings → Personal access tokens
2. Generate new token (classic)
3. Изберете scopes: `repo`
4. Копирайте токена
5. Използвайте токена вместо парола при push

---

## ✅ След качването

### 1. Проверете репозиторията
Посетете: https://github.com/Sureebi/TMW-contracts

### 2. Добавете Topics
В GitHub:
- Settings → Topics
- Добавете: `qbcore`, `fivem`, `vehicle-sale`, `lua`, `contract`, `tmw`

### 3. Проверете README
- Уверете се че `preview.png` се показва
- Проверете форматирането

### 4. Споделете!
- Споделете линка в Discord/Forum
- Добавете в FiveM resources списъци

---

## 📞 Нужда от помощ?

Ако имате проблеми:
1. Проверете дали Git е инсталиран: `git --version`
2. Проверете дали сте логнати в GitHub: `git config user.name`
3. Използвайте GitHub Desktop за по-лесно качване

---

**Repository URL:** https://github.com/Sureebi/TMW-contracts

Успех! 🚀
