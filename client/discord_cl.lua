ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

local time		= 350
local bigtext	= 'ID: ' .. GetPlayerServerId(NetworkGetEntityOwner(PlayerPedId())) .. ' | '.. #GetActivePlayers() .. '/' .. tostring(32)

Citizen.CreateThread(function()
	while true do
		if ESX ~= nil then
			if ESX.PlayerData.job then
				SetDiscordRichPresenceAssetSmall(ESX.PlayerData.job.name)
				SetDiscordRichPresenceAssetSmallText(ESX.PlayerData.job.label .. " - " .. ESX.PlayerData.job.grade_label)	
			else
				Citizen.Wait(time)
			end
		end
		location()
		SetDiscordAppId(Config.Discord)
		SetDiscordRichPresenceAsset(Config.bigimage)
		SetDiscordRichPresenceAssetText(bigtext)
		Citizen.Wait(30*1000)
	end
end)

function location()
	local ped			= PlayerPedId()		
	local x,y,z			= table.unpack(GetEntityCoords(ped,true))
	local StreetHash 	= GetStreetNameAtCoord(x, y, z)
	Citizen.Wait(time)
	if StreetHash ~= nil then
		ESX.TriggerServerCallback('pe-utils:info', function(receivedData)
		local firstname = receivedData.firstname
		local carname = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(ped))))
		StreetName = GetStreetNameFromHashKey(StreetHash)
		if IsPedOnFoot(ped) and not IsEntityInWater(ped) then
			if IsPedSprinting(ped) then
				SetRichPresence(firstname .. " esta parado en " .. StreetName)
			elseif IsPedRunning(ped) then
				SetRichPresence(firstname .. " esta corriendo en " .. StreetName)
			elseif IsPedWalking(ped) then
				SetRichPresence(firstname .. " esta caminando en " .. StreetName)
			elseif IsPedStill(ped) then
				SetRichPresence(firstname .. " esta parado en ".. StreetName)
			end
		elseif GetVehiclePedIsUsing(ped) ~= nil and not IsPedInAnyHeli(ped) and not IsPedInAnyPlane(ped) and not IsPedOnFoot(ped) and not IsPedInAnySub(ped) and not IsPedInAnyBoat(ped) then
			local VehSpeed = GetEntitySpeed(GetVehiclePedIsUsing(ped))
			local CurSpeed = UseKMH and math.ceil(VehSpeed * 3.6) or math.ceil(VehSpeed * 2.236936)
			if CurSpeed > 50 then
				SetRichPresence(firstname .." esta acelerando en " .. StreetName .. " en un " .. carname)
			elseif CurSpeed <= 50 and CurSpeed > 0 then
				SetRichPresence(firstname .. " esta manejando en " .. StreetName .. " en un " .. carname)
			elseif CurSpeed == 0 then
				SetRichPresence(firstname .. " esta estacionado en " .. StreetName .. " en un " .. carname)
			end
		elseif IsPedInAnyHeli(ped) or IsPedInAnyPlane(ped) then
			if IsEntityInAir(GetVehiclePedIsUsing(ped)) or GetEntityHeightAboveGround(GetVehiclePedIsUsing(ped)) > 5.0 then
				SetRichPresence(firstname .. " esta volando sobre " ..StreetName .." en un " .. carname)
			else
				SetRichPresence(firstname .. " esta estacionado en " .. StreetName .. " en un " .. carname)
			end
		elseif IsEntityInWater(ped) then
			SetRichPresence(firstname .. " esta nadando")
		elseif IsPedInAnyBoat(ped) and IsEntityInWater(GetVehiclePedIsUsing(ped)) then
			SetRichPresence(firstname .. " esta navegando en un " .. carname)
		elseif IsPedInAnySub(ped) and IsEntityInWater(GetVehiclePedIsUsing(ped)) then
			SetRichPresence(firstname .. " esta en un sumergible")
		end
		end)
	end
end
