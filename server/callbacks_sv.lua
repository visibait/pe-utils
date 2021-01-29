ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback("pe-utils:info", function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)

    local cbData = {
        firstname    = xPlayer.get('firstName')
    }

    cb(cbData)
end)