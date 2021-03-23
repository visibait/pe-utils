Citizen.CreateThread(function()
	while Config.DropWeapons do
		Citizen.Wait(1000)
		NoWeapons()
	end
end)

local isarmed = false

Citizen.CreateThread(function()
    while Config.Actions do
        Citizen.Wait(5)
        local ped = PlayerPedId()

        if not IsControlPressed(0, 330) or not IsControlPressed(0, 331) then
            DisablePlayerFiring(ped, true)
            DisableControlAction(0, 142, true)
        end

        if isarmed then
            DisableControlAction(1, 140, true)
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
        end
    end
end)

Citizen.CreateThread(function()
    while Config.Actions do
        Citizen.Wait(250) -- You can lower this number if the function doesn't work correctly.
	local _ped = PlayerPedId()
			
	isarmed = false
			
	if IsPedArmed(_ped, 6) then
	   isarmed = true
	end
   end
end)
			

-- No weapons drop on player's death
NoWeapons = function()
	local handle, ped = FindFirstPed()
	local finished = false

	repeat
		if not IsEntityDead(ped) then
			SetPedDropsWeaponsWhenDead(ped, false)
		end
		finished, ped = FindNextPed(handle)
	until not finished

	EndFindPed(handle)
end
