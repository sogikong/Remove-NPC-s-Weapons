Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000) -- ka�d�ch 1 sekund
        
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        -- Naj�t v�echny peds v okol�
        local peds = GetNearbyPeds(playerCoords, 100.0)

        for _, ped in ipairs(peds) do
            if not IsPedAPlayer(ped) then
                -- Odebrat v�echny zbran� od NPC
                RemoveAllPedWeapons(ped, true)
            end
        end
    end
end)

function GetNearbyPeds(playerCoords, radius)
    local peds = {}
    local handle, ped = FindFirstPed()
    local success
    repeat
        local pedPos = GetEntityCoords(ped)
        if DoesEntityExist(ped) and not IsPedAPlayer(ped) and #(playerCoords - pedPos) <= radius then
            table.insert(peds, ped)
        end
        success, ped = FindNextPed(handle)
    until not success
    EndFindPed(handle)
    return peds
end
