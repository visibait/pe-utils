local id = GetPlayerServerId(NetworkGetEntityOwner(PlayerPedId()))
local name = GetPlayerName(PlayerPedId())
local players = #GetActivePlayers() .. '/' .. tostring(32)
local servername = '~b~ Project Entity ~w~| ~o~ID: '

Citizen.CreateThread(function()
    AddTextEntry('FE_THDR_GTAO', servername .. id .. ' ~w~| ~p~Name: ' .. name .. '~w~ | ~g~' .. players)
end)
