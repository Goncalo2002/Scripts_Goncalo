vRP = Proxy.getInterface("vRP")

local menuEnabled = false

RegisterNetEvent("ToggleActionmenu")
AddEventHandler("ToggleActionmenu", function()
	ToggleActionMenu()
end)

function ToggleActionMenu()
	Citizen.Trace("tutorial launch")
	menuEnabled = not menuEnabled
	if ( menuEnabled ) then
		SetNuiFocus( true, true )
		SendNUIMessage({
			showPlayerMenu = true
		})
	else
		SetNuiFocus( false )
		SendNUIMessage({
			showPlayerMenu = false
		})
	end
end

function killTutorialMenu()
SetNuiFocus( false )
		SendNUIMessage({
			showPlayerMenu = false
		})
		menuEnabled = false

end


RegisterNUICallback('close', function(data, cb)
  ToggleActionMenu()
  cb('ok')
end)

Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(0)
		DrawMarker(27, 1842.5758056641,3701.1630859375,1.0600003004074, 0, 0, 0, 0, 0, 0, 1.0001,1.0001,1.0001, 0, 232, 255, 155, 0, 0, 0, 0, 0, 0, 0)
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 1842.5758056641,3701.1630859375,1.0600003004074, true ) < 1 then
			DisplayHelpText("Pressione ~g~E~s~ para aceder ao arsenal GNR")
		 if (IsControlJustReleased(1, 51)) then
			SetNuiFocus( true, true )
			SendNUIMessage({
				showPlayerMenu = true
			})
		 end
		end
	end
end)

RegisterNUICallback('recruta', function(data, cb)
	TriggerServerEvent('recruta:checkmoney')
  	cb('ok')
end)

RegisterNUICallback('guarda', function(data, cb)
	TriggerServerEvent('guarda:checkmoney')
  	cb('ok')
end)

RegisterNUICallback('cabo', function(data, cb)
	TriggerServerEvent('cabo:checkmoney')
  	cb('ok')
end)

RegisterNUICallback('coronel', function(data, cb)
	TriggerServerEvent('coronel:checkmoney')
  	cb('ok')
end)

RegisterNUICallback('major', function(data, cb)
	TriggerServerEvent('major:checkmoney')
  	cb('ok')
end)

RegisterNUICallback('tenente', function(data, cb)
	TriggerServerEvent('tenente:checkmoney')
  	cb('ok')
end)

RegisterNUICallback('closeButton', function(data, cb)
	killTutorialMenu()
  	cb('ok')
end)

function DrawSpecialText(m_text, showtime)
	SetTextEntry_2("STRING")
	AddTextComponentString(m_text)
	DrawSubtitleTimed(showtime, 1)
end

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
