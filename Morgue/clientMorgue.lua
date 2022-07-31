--Coded by Albo1125.
-- /////// I take no credits for this, this was 100% coded by Albo1125./////
--Modified by Kevin.


TriggerEvent('chat:addSuggestion', "/morgue", "Morgues a player", {
    { name="Password", help="coroner" } ,
    { name="ID", help="ID of player you are wanting to morgue" },
    { name="Time", help="Time you want this player morgue" }
})
    
    TriggerEvent('chat:addSuggestion', "/unmorgue", "Unmorgue a player", {
        { name="Password", help="coroner"} ,
        { name="ID", help="ID of player you are wanting to unmorgue" } ,
})

    
    TriggerEvent('chat:addSuggestion', "/morgueme", "Morgues yourself", {
        { name="Time", help="Time you want to morgue yourself" }
})


local cH = false
local eHE = false

RegisterNetEvent("M")
AddEventHandler("M", function(hT)
	if cH == true then
		return
	end
	local pP = GetPlayerPed(-1)
	if DoesEntityExist(pP) then

		Citizen.CreateThread(function()
			local playerOldLoc = GetEntityCoords(pP, true)
			SetEntityCoords(pP, -1762.28, -262.07, 48.31)
			cH = true
			eHE = false
			while hT > 0 and not eHE do
				pP = GetPlayerPed(-1)
				RemoveAllPedWeapons(pP, true)
				SetEntityInvincible(pP, true)
				if IsPedInAnyVehicle(pP, false) then
					ClearPedTasksImmediately(pP)
				end
				if hT % 30 == 0 then
					TriggerEvent('chatMessage', 'SYSTEM', { 0, 0, 0 }, hT .." more seconds until release.")
				end
				Citizen.Wait(500)
				local pL = GetEntityCoords(pP, true)
				local D = Vdist(-1762.28, -262.07, 48.31, pL['x'], pL['y'], pL['z'])
				if D > 90 then
					SetEntityCoords(pP, 360.28, -591.07, 43.31)
					if D > 100 then
						hT = hT + 60
						if hT > 1500 then
							hT = 1500
						end
						TriggerEvent('chatMessage', 'CORONER', { 0, 0, 0 }, "Your death time was extended because you tried to leave.")
					end
				end
				hT = hT - 0.5
			end
			TriggerServerEvent('chatMessageEntered', "SYSTEM", { 0, 0, 0 }, GetPlayerName(PlayerId()) .." was released from the hospital.")
			SetEntityCoords(pP, -1762.28, -262.07, 48.31)
			cJ = false
			SetEntityInvincible(pP, false)
		end)
	end
end)

RegisterNetEvent("UnM")
AddEventHandler("UnM", function()
	eHE = true
end)
--Coded by Albo1125
--Modified by Kevin.
