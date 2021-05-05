local isArmed = false

CreateThread(function()
	while Config.DropWeapons do
		Wait(1000)
		NoWeapons()
	end
end)

CreateThread(function()
    while Config.Actions do
        Wait(5)
        local ped = PlayerPedId()
        if not IsControlPressed(0, 330) or not IsControlPressed(0, 331) then
            DisablePlayerFiring(ped, true)
            DisableControlAction(0, 142, true)
        end
        if isArmed then
            DisableControlAction(1, 140, true)
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
        end
    end
end)

CreateThread(function()
    while Config.Actions do
        Wait(200) -- You can lower this number if the function doesn't work correctly.
	local ped = PlayerPedId()
	if IsPedArmed(ped, 6) then
		isArmed = true
	else
		isArmed = false
	end
   end
end)
			

-- No weapons drop on player's death
function NoWeapons()
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
