
local canDraw = false
local canDraw2 = false
Citizen.CreateThread(function()
	
	while true do
		w = 1000	
		if IsPedInAnyVehicle(PlayerPedId(), false) then
			w = 100
			if IsWarningMessageActive() and tonumber(GetWarningMessageTitleHash()) == 1246147334 then
				ClearPedTasksImmediately(PlayerPedId())
				RemoveWarningMessageListItems(1246147334)
				--TriggerServerEvent("InteractSound_SV:PlayOnSource", "lamminleipa", 1.0) --Laita tähän oma soundi jos haluat
				Scaleforms()
			end
		else 
			w = 1000
		end
		Citizen.Wait(w)
	end
end)

RegisterNetEvent('s_alt:sync', function(nekruc, violator)
	canDraw2 = 4000
	while canDraw2 > 0 do
		koords = GetEntityCoords(PlayerPedId())
		dist = #(koords - nekruc)
		w = 4 
		if dist <= 40 then
			Draw3DText(nekruc.x, nekruc.y, nekruc.z + 1.23, '~r~ALT F4~s~ Abusaaja, No se on meitsi :333333 [ID: ' ..violator.. ']')
		end
		if canDraw2 then
			canDraw2 = canDraw2 - 10
		end
		Wait(w)
	end
end)

--scaleformit sun muut
function Scaleforms()
	local scaleform = RequestScaleformMovie("MP_BIG_MESSAGE_FREEMODE")
	while not HasScaleformMovieLoaded(scaleform) do
		Citizen.Wait(10)
	end
	local coords = GetEntityCoords(PlayerPedId())
	local pedid = GetPlayerServerId(PlayerId())
	TriggerServerEvent('s_alt:sync', coords, pedid)
	canDraw = 5000
	BeginScaleformMovieMethod(scaleform, "SHOW_WEAPON_PURCHASED")
	PushScaleformMovieMethodParameterString("~r~ALT F4?~s~")
	PushScaleformMovieMethodParameterString("~g~Toimintasi on logattu ja ylläpito on tietoinen toiminnastasi. (Glitch / Bug abuse)")
	ScaleformMovieMethodAddParamInt(5)
	EndScaleformMovieMethod()
	while canDraw > 0 do
		DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
		w = 5
		Wait(w)
		if canDraw then
			canDraw = canDraw - 10
		end
	end

end

function Draw3DText(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 159)
end
