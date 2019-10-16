-- how to use this

-- Create Pickup
TriggerClientEvent('ews:createPickup', -1, { id = 'PICKUP_WEAPON_MUSKET', blipId = 158 }, {x = 1, y = 1, z = 1}, 1 ) 

-- Destory Pickup
TriggerClientEvent('ews:removeAllPickup', -1)
