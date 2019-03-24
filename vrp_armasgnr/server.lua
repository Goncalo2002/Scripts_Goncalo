local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_armasgnr")


RegisterServerEvent('recruta:checkmoney')
AddEventHandler('recruta:checkmoney', function(player,choice)
local user_id = vRP.getUserId({source})
local player = vRP.getUserSource({user_id})
if vRP.hasGroup({user_id,"GNR"}) then
vRPclient.giveWeapons(player,{{
      ["WEAPON_COMBATPISTOL"] = {ammo=250},
      ["WEAPON_NIGHTSTICK"] = {ammo=200},
      ["WEAPON_STUNGUN"] = {ammo=200},
      ["WEAPON_FLASHLIGHT"] = {ammo=25}
    }, true})
	end
end)

RegisterServerEvent('guarda:checkmoney')
AddEventHandler('guarda:checkmoney', function()
local user_id = vRP.getUserId({source})
local player = vRP.getUserSource({user_id})
if vRP.hasGroup({user_id,"GNR"}) then
vRPclient.giveWeapons(player,{{
      ["WEAPON_COMBATPISTOL"] = {ammo=250},
      ["WEAPON_NIGHTSTICK"] = {ammo=200},
	  ["WEAPON_SMG"] = {ammo=250},
      ["WEAPON_STUNGUN"] = {ammo=200},
      ["WEAPON_FLASHLIGHT"] = {ammo=25}
    }, true})
	end
end)

RegisterServerEvent('cabo:checkmoney')
AddEventHandler('cabo:checkmoney', function()
local user_id = vRP.getUserId({source})
local player = vRP.getUserSource({user_id})
if vRP.hasGroup({user_id,"GNR"}) then
vRPclient.giveWeapons(player,{{
      ["WEAPON_COMBATPISTOL"] = {ammo=250},
      ["WEAPON_PUMPSHOTGUN"] = {ammo=250},
      ["WEAPON_NIGHTSTICK"] = {ammo=200},
      ["WEAPON_STUNGUN"] = {ammo=200},
      ["WEAPON_SMG"] = {ammo=250},
      ["WEAPON_FLASHLIGHT"] = {ammo=25}
    }, true})
	end
end)

RegisterServerEvent('coronel:checkmoney')
AddEventHandler('coronel:checkmoney', function()
local user_id = vRP.getUserId({source})
local player = vRP.getUserSource({user_id})
if vRP.hasGroup({user_id,"GNR"}) then
vRPclient.giveWeapons(player,{{
      ["WEAPON_COMBATPISTOL"] = {ammo=250},
      ["WEAPON_PUMPSHOTGUN"] = {ammo=250},
      ["WEAPON_NIGHTSTICK"] = {ammo=200},
      ["WEAPON_STUNGUN"] = {ammo=200},
      ["WEAPON_SMG"] = {ammo=250},
      ["WEAPON_BZGAS"] = {ammo=25},
      ["WEAPON_FLASHLIGHT"] = {ammo=25}
    }, true})
	end
end)

RegisterServerEvent('major:checkmoney')
AddEventHandler('major:checkmoney', function()
local user_id = vRP.getUserId({source})
local player = vRP.getUserSource({user_id})
if vRP.hasGroup({user_id,"GNR"}) then
vRPclient.giveWeapons(player,{{
      ["WEAPON_COMBATPISTOL"] = {ammo=250},
      ["WEAPON_PUMPSHOTGUN"] = {ammo=250},
      ["WEAPON_NIGHTSTICK"] = {ammo=200},
	  ["WEAPON_CARBINERIFLE"] = {ammo=250},
      ["WEAPON_STUNGUN"] = {ammo=200},
      ["WEAPON_SMG"] = {ammo=250},
      ["WEAPON_BZGAS"] = {ammo=25},
      ["WEAPON_FLASHLIGHT"] = {ammo=25}
    }, true})
	end
end)

RegisterServerEvent('tenente:checkmoney')
AddEventHandler('tenente:checkmoney', function()
local user_id = vRP.getUserId({source})
local player = vRP.getUserSource({user_id})
if vRP.hasGroup({user_id,"GNR"}) then
vRPclient.giveWeapons(player,{{
      ["WEAPON_COMBATPISTOL"] = {ammo=250},
      ["WEAPON_PUMPSHOTGUN"] = {ammo=250},
      ["WEAPON_NIGHTSTICK"] = {ammo=200},
	  ["WEAPON_CARBINERIFLE"] = {ammo=250},
      ["WEAPON_STUNGUN"] = {ammo=200},
      ["WEAPON_SMG"] = {ammo=250},
      ["WEAPON_BZGAS"] = {ammo=25},
      ["WEAPON_FLASHLIGHT"] = {ammo=25}
    }, true})
	end
end)