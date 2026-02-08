QBCore = exports['qb-core']:GetCoreObject()
RegisterNUICallback('escape', function()
    SetNuiFocus(false, false)
end)
RegisterNUICallback('writecontract', function(data)
    TriggerServerEvent('kzo_contract:writecontact', data.closestplayer, data.plate, data.price)
end)
Citizen.CreateThread(function()
    RequestAnimDict('anim@amb@nightclub@peds@')
	while not HasAnimDictLoaded('anim@amb@nightclub@peds@') do
		Citizen.Wait(0)
	end
end)
RegisterNetEvent('kzo_contract:useitem', function()
    local vehicle, distance = QBCore.Functions.GetClosestVehicle()
    local player, distancep = QBCore.Functions.GetClosestPlayer()
    if vehicle ~= -1 and distance < 3.5 and player ~= -1 and distancep < 3.5 then
        QBCore.Functions.TriggerCallback('kzo_contract:getclosestplayername', function(name, playername)

            SetNuiFocus(true, true)
            SendNUIMessage({
                action = 'opencontract',
                plate = QBCore.Functions.GetPlate(vehicle),
                name = name,
                playername = playername,
                closestid = GetPlayerServerId(player),
            })

        end, GetPlayerServerId(player))
    else
        QBCore.Functions.Notify('Không có xe hoặc người chơi nào ở gần bạn!', 'error')
    end
end)
RegisterNetEvent('kzo_contract:showAnim')
AddEventHandler('kzo_contract:showAnim', function(player)
	TaskStartScenarioInPlace(PlayerPedId(), 'WORLD_HUMAN_CLIPBOARD', 0, true)
	Citizen.Wait(10000)
	ClearPedTasks(PlayerPedId())
end)

-- Прогресбар за подписване на договора
RegisterNetEvent('kzo_contract:startProgress', function(role, otherPlayerName)
    local label = ''
    local notifyMsg = ''
    
    if role == 'seller' then
        label = 'Подписвате договора за продажба на ' .. otherPlayerName
        notifyMsg = 'Започвате подписване на договора за продажба...'
    else
        label = 'Подписвате договора за покупка от ' .. otherPlayerName
        notifyMsg = 'Започвате подписване на договора за покупка...'
    end
    
    QBCore.Functions.Notify(notifyMsg, 'primary', 3000)
    
    -- Анимация
    TaskStartScenarioInPlace(PlayerPedId(), 'WORLD_HUMAN_CLIPBOARD', 0, true)
    
    -- Проверка дали има qb-progressbar
    if GetResourceState('progressbar') == 'started' or GetResourceState('qb-progressbar') == 'started' then
        exports['progressbar']:Progress({
            name = "contract_signing",
            duration = 11000,
            label = label,
            useWhileDead = false,
            canCancel = false,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
        }, function(cancelled)
            ClearPedTasks(PlayerPedId())
        end)
    else
        -- Fallback ако няма progressbar - използва QBCore прогресбар
        QBCore.Functions.Progressbar("contract_signing", label, 11000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            ClearPedTasks(PlayerPedId())
        end, function() -- Cancel
            ClearPedTasks(PlayerPedId())
        end)
    end
    
    Citizen.Wait(10000)
    ClearPedTasks(PlayerPedId())
end)



-- Команда за тестване на UI
RegisterCommand('testui', function()
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
    local plate = 'TEST123'
    
    if vehicle ~= 0 then
        plate = QBCore.Functions.GetPlate(vehicle)
    end
    
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'opencontract',
        plate = plate,
        name = 'Иван Иванов',
        playername = 'Петър Петров',
        closestid = 1,
    })
end, false)
