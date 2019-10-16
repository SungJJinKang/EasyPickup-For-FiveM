-- how to use this 

-- Create Pickup (EXAMPLE)
TriggerClientEvent('ews:createPickup', -1, { id = 'PICKUP_WEAPON_MUSKET', blipId = 158 }, {x = 1, y = 1, z = 1}, 1 ) -- { id : pickupid, blipid : blipid }, { coords }, ammount

-- Destory Pickup (EXAMPLE)
TriggerClientEvent('ews:removeAllPickup', -1)
