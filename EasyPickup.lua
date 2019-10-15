local pickupContainers = {} -- Local pickups data

--this events should be call in server side script
RegisterNetEvent('ews:createPickups') -- Generates all the pickups
RegisterNetEvent('ews:createPickup') -- Generates all the pickups
RegisterNetEvent('ews:removePickup') -- Remove a pickup
RegisterNetEvent('ews:removeAllPickup') -- Remove a All pickup

function RemovePickupContainer(pickupContainer)
  if pickupContainer.pickup ~= nil then
    RemovePickup(pickupContainer.pickup)
    pickupContainer.pickup = nil
  end

  if pickupContainer.blip ~= nil then
    RemoveBlip(pickupContainer.blip)
    pickupContainer.blip = nil
  end
end

function RemoveAllPickups()
  for k, pickupContainer in pairs(pickupContainers) do
    RemovePickupContainer(pickupContainer)
    pickupContainers[k] = nil
  end
end



AddEventHandler('ews:removeAllPickup', function()

  RemoveAllPickups()

end)

AddEventHandler('ews:createPickups', function(pickUpDatas)

  for _, p in pairs(pickUpDatas)  do
    CreatPickup(p.pickupItem, p.location, 5.0) -- 5.0 is ammo amount, You can change
  end
  
  
end)

-- Create pickups which are the same for each player
AddEventHandler('ews:createPickup', function(pickupItem, location, amount)

  CreatPickup(pickupItem, location, amount)
  
end)

function CreatPickup(pickupItem, location, amount)   

  local pickupHash = GetHashKey(pickupItem.id)

  local pickup = CreatePickupRotate(pickupHash, location.x, location.y, location.z - 0.4, 0.0, 0.0, 0.0, 512, amount) -- Create pickup
  local blip = AddPickupBlip(pickupItem.blipId, location) -- Add Blip

  table.insert( pickupContainers, {pickup = pickup, blip = blip} )

end

-- Remove a pickup
AddEventHandler('ews:removePickup', function(pickupContainer)
  RemovePickupContainer(pickupContainer)
end)


function AddPickupBlip(id, coords)
  local blip = AddBlipForCoord(coords.x, coords.y, coords.z)

  SetBlipSprite(blip, id)
  SetBlipHighDetail(blip, true)
  SetBlipAsShortRange(blip, true)

  return blip
end



-- Check pickup collection
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(50)

        for _, pickupContainer in pairs(pickupContainers) do
          if HasPickupBeenCollected(pickupContainer.pickup) then

            RemovePickupContainer(pickupContainer)
          end
        end
    
  end
end)

