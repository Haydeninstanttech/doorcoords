--cloudsparc development simple doorcoords--

RegisterCommand("getdoorcoords", function(source, args, raw)
    local playerPed = PlayerPedId()
    local playerPos = GetEntityCoords(playerPed)

    -- Get the forward vector to determine where the player is facing
    local forwardVector = GetEntityForwardVector(playerPed)
    local raycastLength = 5.0 -- Distance to scan for door
    local rayEndPos = playerPos + forwardVector * raycastLength

    -- Perform a raycast in front of the player to detect objects
    local rayHandle = StartShapeTestRay(playerPos.x, playerPos.y, playerPos.z, rayEndPos.x, rayEndPos.y, rayEndPos.z, 16, playerPed, 0)
    local _, hit, endCoords, surfaceNormal, entityHit = GetShapeTestResult(rayHandle)

    if hit and entityHit ~= 0 then
        -- Get the coordinates of the door/entity the player is looking at
        local doorCoords = GetEntityCoords(entityHit)
        local coordsText = string.format("Door Coordinates: x = %.2f, y = %.2f, z = %.2f", doorCoords.x, doorCoords.y, doorCoords.z)
        -- Output to chat
        TriggerEvent('chat:addMessage', {
            args = { coordsText }
        })
    else
        TriggerEvent('chat:addMessage', {
            args = { "No door found within range." }
        })
    end
end, false)