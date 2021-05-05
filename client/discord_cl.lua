local Wait = Wait

ESX = nil

CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Wait(10)
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

local prevframes, prevtime, curtime, curframes, fps = 0, 0, 0, 0, 0
local time		= 350
local bigtext	= 'ID: ' .. GetPlayerServerId(NetworkGetEntityOwner(PlayerPedId()))
--local text 		= 'ID: ' .. GetPlayerServerId(NetworkGetEntityOwner(PlayerPedId())) .. ' | '.. GetFrameCount() .. ' FPS'

CreateThread(function()

	while not NetworkIsPlayerActive(PlayerId()) or not NetworkIsSessionStarted() do
        Wait(0)
        prevframes = GetFrameCount()
        prevtime = GetGameTimer()
    end

	while true do
		curtime = GetGameTimer()
        curframes = GetFrameCount()
		if (curtime - prevtime) > 1000 then
            fps = (curframes - prevframes) - 1              
            prevtime = curtime
            prevframes = curframes
        end

		if fps > 0 and fps < 1000 then
			SetRichPresence('ID: ' ..  GetPlayerServerId(NetworkGetEntityOwner(PlayerPedId())) .. ' | ' .. 'FPS: ' .. fps)
		end

		if ESX ~= nil then
			if ESX.PlayerData.job then
				SetDiscordRichPresenceAssetSmall(ESX.PlayerData.job.name)
				SetDiscordRichPresenceAssetSmallText(ESX.PlayerData.job.label .. " - " .. ESX.PlayerData.job.grade_label)	
			else
				Wait(time)
			end
		end
		SetDiscordAppId(Config.Discord)
		SetDiscordRichPresenceAsset(Config.bigimage)
		SetDiscordRichPresenceAssetText(bigtext)
		SetDiscordRichPresenceAction(0, 'Click?', 'https://www.youtube.com/watch?v=R0lqowYD_Tg')
		Citizen.Wait(3*1000)
	end
end)
