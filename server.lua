QBCore = exports['qb-core']:GetCoreObject()
local itemname = 'contract'
QBCore.Functions.CreateCallback('kzo_contract:getclosestplayername', function(source, cb, closestid)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    local closestPlayer = QBCore.Functions.GetPlayer(closestid)
    local xName = xPlayer.PlayerData.charinfo.firstname .. ' ' .. xPlayer.PlayerData.charinfo.lastname
    local closestName = closestPlayer.PlayerData.charinfo.firstname .. ' ' .. closestPlayer.PlayerData.charinfo.lastname
    cb(xName, closestName)
end)
QBCore.Functions.CreateUseableItem(itemname, function(source, item)
    TriggerClientEvent("kzo_contract:useitem", source)
end)
RegisterNetEvent('kzo_contract:writecontact', function(closestplayer, plate, price)
    local src = source
    local target = tonumber(closestplayer)
    
    print('Contract Debug - src:', src, 'target:', target, 'plate:', plate, 'price:', price, 'type:', type(price))
    
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local closestPlayer = QBCore.Functions.GetPlayer(target)
    
    if not xPlayer or not closestPlayer then
        TriggerClientEvent("QBCore:Notify", src, "Играчът не е намерен! ID: " .. tostring(target), "error")
        print('Contract Debug - Player not found. xPlayer:', xPlayer, 'closestPlayer:', closestPlayer)
        return
    end
    
    local salePrice = tonumber(price) or 0
    
    print('Contract Debug - salePrice after tonumber:', salePrice)
    
    if salePrice <= 0 then
        TriggerClientEvent("QBCore:Notify", src, "Невалидна цена за продажба!", "error")
        return
    end
    
    local xCitizen = xPlayer.PlayerData.citizenid
    local tCitizen = closestPlayer.PlayerData.citizenid
    local tidentifier = closestPlayer.PlayerData.license
    local xName = xPlayer.PlayerData.charinfo.firstname .. ' ' .. xPlayer.PlayerData.charinfo.lastname
    local closestName = closestPlayer.PlayerData.charinfo.firstname .. ' ' .. closestPlayer.PlayerData.charinfo.lastname
    
    -- Проверка дали купувачът има достатъчно пари
    if closestPlayer.PlayerData.money.cash < salePrice and closestPlayer.PlayerData.money.bank < salePrice then
        TriggerClientEvent("QBCore:Notify", src, closestName .. " няма достатъчно пари за покупката!", "error")
        TriggerClientEvent("QBCore:Notify", target, "Нямате достатъчно пари за тази покупка! Цена: $" .. salePrice, "error")
        return
    end
    
    -- Стартиране на прогресбар за продавача
    TriggerClientEvent('kzo_contract:startProgress', src, 'seller', closestName)
    Wait(11000)
    
    -- Стартиране на прогресбар за купувача
    TriggerClientEvent('kzo_contract:startProgress', target, 'buyer', xName)
    Wait(11000)
    
    MySQL.Async.fetchAll("SELECT * FROM player_vehicles WHERE plate = @plate AND citizenid = @citizen", {
        ["@plate"] = plate,
        ["@citizen"] = xCitizen
    }, function(result)
        if result[1] ~= nil then
            if xPlayer.Functions.RemoveItem(itemname, 1) then
                -- Прехвърляне на парите
                local paymentSuccess = false
                
                if closestPlayer.PlayerData.money.cash >= salePrice then
                    closestPlayer.Functions.RemoveMoney('cash', salePrice, "vehicle-purchase")
                    xPlayer.Functions.AddMoney('cash', salePrice, "vehicle-sale")
                    paymentSuccess = true
                elseif closestPlayer.PlayerData.money.bank >= salePrice then
                    closestPlayer.Functions.RemoveMoney('bank', salePrice, "vehicle-purchase")
                    xPlayer.Functions.AddMoney('bank', salePrice, "vehicle-sale")
                    paymentSuccess = true
                end
                
                if paymentSuccess then
                    -- Прехвърляне на превозното средство
                    MySQL.Sync.execute(
                        'UPDATE `player_vehicles` SET license = @license, citizenid = @citizenid WHERE plate = @plate',
                        {
                            ['@license'] = tidentifier,
                            ['@citizenid'] = tCitizen,
                            ['@plate'] = plate,
                        })
                    
                    TriggerClientEvent("QBCore:Notify", src, "Успешно продадохте превозното средство с номер " .. plate .. " на " .. closestName .. " за $" .. salePrice .. "!", "success")
                    TriggerClientEvent("QBCore:Notify", target, "Успешно закупихте превозното средство с номер " .. plate .. " от " .. xName .. " за $" .. salePrice .. "!", "success")
                    TriggerClientEvent("vehiclekeys:client:SetOwner", target, plate)
                else
                    xPlayer.Functions.AddItem(itemname, 1)
                    TriggerClientEvent("QBCore:Notify", src, "Грешка при плащането!", "error")
                end
            end
        else
            TriggerClientEvent("QBCore:Notify", src, "Превозното средство с номер " .. plate .. " не е ваше!", "error")
        end
    end)
end)

-- Тестова команда за прехвърляне на превозно средство
QBCore.Commands.Add('testcontract', 'Тествай прехвърлянето на превозно средство (само за тестване)', {{name = 'plate', help = 'Номер на превозното средство'}, {name = 'price', help = 'Цена на продажбата'}}, true, function(source, args)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local plate = args[1]:upper()
    local testPrice = tonumber(args[2]) or 0
    local xCitizen = xPlayer.PlayerData.citizenid

    if testPrice <= 0 then
        TriggerClientEvent("QBCore:Notify", src, "ТЕСТ: Моля, въведете валидна цена! Пример: /testcontract ABC123 50000", "error")
        return
    end

    TriggerClientEvent('kzo_contract:showAnim', src)
    Wait(11000)

    MySQL.Async.fetchAll("SELECT * FROM player_vehicles WHERE plate = @plate AND citizenid = @citizen", {
        ["@plate"] = plate,
        ["@citizen"] = xCitizen
    }, function(result)
        if result[1] ~= nil then
            if xPlayer.Functions.RemoveItem(itemname, 1) then
                TriggerClientEvent("QBCore:Notify", src, "ТЕСТ: Превозното средство с номер " .. plate .. " е твое и може да бъде продадено за $" .. testPrice .. "!", "success")
                TriggerClientEvent("QBCore:Notify", src, "Анимацията и проверката работят правилно!", "success")
                -- Връщаме предмета обратно за тестване
                xPlayer.Functions.AddItem(itemname, 1)
            else
                TriggerClientEvent("QBCore:Notify", src, "ТЕСТ: Нямаш предмета '" .. itemname .. "' в инвентара!", "error")
            end
        else
            TriggerClientEvent("QBCore:Notify", src, "ТЕСТ: Превозното средство с номер " .. plate .. " не е твое или не съществува!", "error")
        end
    end)
end, 'admin')
