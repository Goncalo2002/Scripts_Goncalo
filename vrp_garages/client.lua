--[[
#######################################################
#################Editado Por###########################
################Gonçalo-)#6824#########################
##########https://discord.gg/ABWPUTH###################
#######################################################
]]

--[[Proxy/Tunnel]]--

vRPgt = {}
Tunnel.bindInterface("vRP_garages",vRPgt)
Proxy.addInterface("vRP_garages",vRPgt)
vRP = Proxy.getInterface("vRP")

--[[Local/Global]]--

GVEHICLES = {}
local inrangeofgarage = false
local currentlocation = nil

local garages = {
    {name="Garagem", colour=2, id=357, x=215.124, y=-791.377, z=30.946, h=0.0},
    {name="Garagem", colour=2, id=357, x=1868.1461181641, y=2550.7780761719, z=44.854049682617, h=0.0},
    {name="Garagem", colour=2, id=357, x=-90.235275268555, y=-2516.3706054688, z=6.0009918212891, h=0.0},
    {name="Garagem", colour=2, id=357, x=-423.96020507813, y=-1685.2033691406, z=19.029064178467, h=0.0},
    {name="Garagem", colour=2, id=357, x=-334.685, y=289.773, z=85.705, h=0.0},
    {name="Garagem", colour=2, id=357, x=-55.272, y=-1838.71, z=26.442, h=0.0},
    {name="Garagem", colour=2, id=357, x=126.434, y=6610.04, z=30.750, h=0.0},
  	{name="Garagem", colour=2, id=357, x=294.53143310547, y=-342.1376953125, z=44.91987991333, h=0.0},
    {name="Garagem", colour=2, id=357, x=1230.9146728516, y=-2678.0639648438, z=2.7148849964142, h=0.0}, --Garaj linia 1000 din vrp/cfg/garages.lua
    {name="Garagem", colour=2, id=357, x=684.44097900391, y=-719.58734130859, z=25.884830474854, h=0.0},
    {name="Garagem", colour=2, id=357, x=1671.0228271484, y=-48.51448059082, z=173.7746887207, h=0.0},
	{name="Garagem", colour=2, id=357, x=-409.75796508789, y=1179.1926269531, z=325.62850952148, h=0.0},
	{name="Garagem", colour=2, id=357, x=-2577.6257324219, y=1929.0706787109, z=167.4503326416, h=0.0},	
	{name="Garagem", colour=2, id=357, x=-366.59368896484, y=-116.3374786377, z=38.696319580078, h=0.0},
	{name="Garagem", colour=2, id=357, x=215.93348693848, y=-1375.0686035156, z=30.586996078491, h=0.0},
	{name="Garagem", colour=2, id=357, x=-1157.5943603516, y=-1740.3787841797, z=4.0561184883118, h=0.0},	
    {name="Garagem", colour=2, id=357, x=-638.08142089844, y=56.500617980957, z=43.794803619385, h=0.0},
    {name="Garagem", colour=2, id=357, x=-1457.4909667969, y=-500.61614990234, z=32.202766418457, h=0.0},	
    {name="Garagem", colour=2, id=357, x=-2646.0869140625, y=1307.0513916016, z=146.08067321777, h=0.0},		
  	{name="Garagem", colour=2, id=357, x=-1805.4360351563, y=456.56448364258, z=128.28353881836, h=0.0},
    {name="Garagem", colour=2, id=357, x=-503.14678955078, y=-5552.4521484375, z=780.49847412109, h=0.0},	
    {name="Garagem", colour=2, id=357, x=-25.273494720459, y=-1434.4365234375, z=30.653142929077, h=0.0},
    {name="Garagem", colour=2, id=357, x=-819.40551757813, y=183.72904968262, z=72.136161804199, h=0.0},
   	{name="Garagem", colour=2, id=357, x=-119.89024353027, y=986.86151123047, z=235.75003051758, h=0.0},
    {name="Garagem", colour=2, id=357, x=1977.1169433594, y=3827.2368164063, z=32.373237609863, h=0.0},
    {name="Garagem", colour=2, id=357, x=2480.5893554688, y=4953.958984375, z=45.026481628418, h=0.0},
    {name="Garagem", colour=2, id=357, x=15.016004562378, y=547.76171875, z=176.14279174805, h=0.0},
    {name="Garagem", colour=2, id=357, x=-299.44692993164, y=-982.86956787109, z=31.080791473389, h=0.0},
    {name="Garagem", colour=2, id=357, x=-232.18531799316, y=-1276.1887207031, z=31.295980453491, h=0.0},
    {name="Garagem", colour=2, id=357, x=-1415.1351318359, y=-956.41815185547, z=7.2369647026062, h=0.0},
    {name="Garagem", colour=2, id=357, x=497.44073486328, y=-1702.4410400391, z=29.400140762329, h=0.0},
    {name="Garagem", colour=2, id=357, x=-796.00256347656, y=304.55578613281, z=85.700416564941, h=0.0},
    {name="Garagem", colour=2, id=357, x=-249.15977478027, y=-694.24932861328, z=33.542774200439, h=0.0},
    {name="Garagem", colour=2, id=357, x=-72.769035339355, y=495.79925537109, z=144.10296630859, h=0.0},
    {name="Garagem", colour=2, id=357, x=-121.71002960205, y=509.85540771484, z=142.5652923584, h=0.0},
    {name="Garagem", colour=2, id=357, x=-188.32077026367, y=502.87573242188, z=134.23774719238, h=0.0},
    {name="Garagem", colour=2, id=357, x=1366.5837402344, y=1147.4722900391, z=113.41327667236, h=0.0},
    {name="Garagem", colour=2, id=357, x=-36.333103179932, y=-674.09722900391, z=32.33805847168, h=0.0},
    {name="Garagem", colour=2, id=357, x=1274.7135009766, y=-1732.7083740234, z=52.04536819458, h=0.0},
    {name="Garagem", colour=2, id=357, x=34.516819000244, y=6604.0004882813, z=32.449085235596, h=0.0},
    {name="Garagem", colour=2, id=357, x=-555.20428466797, y=664.56500244141, z=145.16401672363, h=0.0},
    {name="Garagem", colour=2, id=357, x=822.37866210938, y=-2141.8317871094, z=28.912273406982, h=0.0},
    {name="Garagem", colour=2, id=357, x=-47.702621459961, y=-1076.9846191406, z=26.774045944214, h=0.0},
	
}

local garagesguardar = {
  {x=229.02241516113, y=-797.39715576172, z=30.601579666138, h=0.0},
  {x=1868.1461181641, y=2550.7780761719, z=44.854049682617, h=0.0},
  {x=-90.235275268555, y=-2516.3706054688, z=6.0009918212891, h=0.0},
  {x=-423.96020507813, y=-1685.2033691406, z=19.029064178467, h=0.0},
  {x=-334.685, y=289.773, z=85.705, h=0.0},
  {x=-55.272, y=-1838.71, z=26.442, h=0.0},
  {x=126.434, y=6610.04, z=30.750, h=0.0},
  {x=294.53143310547, y=-342.1376953125, z=44.91987991333, h=0.0},
  {x=1230.9146728516, y=-2678.0639648438, z=2.7148849964142, h=0.0}, --Garaj linia 1000 din vrp/cfg/garages.lua
  {x=684.44097900391, y=-719.58734130859, z=25.884830474854, h=0.0},
  { x=1671.0228271484, y=-48.51448059082, z=173.7746887207, h=0.0},
  {x=-409.75796508789, y=1179.1926269531, z=325.62850952148, h=0.0},
  {x=-2577.6257324219, y=1929.0706787109, z=167.4503326416, h=0.0},	
  {x=-366.59368896484, y=-116.3374786377, z=38.696319580078, h=0.0},
  {x=215.93348693848, y=-1375.0686035156, z=30.586996078491, h=0.0},
  {x=-1157.5943603516, y=-1740.3787841797, z=4.0561184883118, h=0.0},	
  {x=-638.08142089844, y=56.500617980957, z=43.794803619385, h=0.0},
  {x=-1457.4909667969, y=-500.61614990234, z=32.202766418457, h=0.0},	
  {x=-2646.0869140625, y=1307.0513916016, z=146.08067321777, h=0.0},		
  {x=-1805.4360351563, y=456.56448364258, z=128.28353881836, h=0.0},
  {x=-503.14678955078, y=-5552.4521484375, z=780.49847412109, h=0.0},	
  {x=-25.273494720459, y=-1434.4365234375, z=30.653142929077, h=0.0},
  {x=-810.40551757813, y=183.72904968262, z=72.136161804199, h=0.0},
  {x=-110.89024353027, y=986.86151123047, z=235.75003051758, h=0.0},
  {x=1970.1169433594, y=3827.2368164063, z=32.373237609863, h=0.0},
  {x=2475.5893554688, y=4953.958984375, z=45.026481628418, h=0.0},
  {x=10.016004562378, y=547.76171875, z=176.14279174805, h=0.0},
  {x=-290.44692993164, y=-982.86956787109, z=31.080791473389, h=0.0},
  {x=-230.18531799316, y=-1276.1887207031, z=31.295980453491, h=0.0},
  {x=-1410.1351318359, y=-956.41815185547, z=7.2369647026062, h=0.0},
  {x=490.44073486328, y=-1702.4410400391, z=29.400140762329, h=0.0},
  {x=-790.00256347656, y=304.55578613281, z=85.700416564941, h=0.0},
  {x=-240.15977478027, y=-694.24932861328, z=33.542774200439, h=0.0},
  {x=-70.769035339355, y=495.79925537109, z=144.10296630859, h=0.0},
  {x=-16.71002960205, y=509.85540771484, z=142.5652923584, h=0.0},
  {x=-180.32077026367, y=502.87573242188, z=134.23774719238, h=0.0},
  {x=1306.5837402344, y=1147.4722900391, z=113.41327667236, h=0.0},
  {x=-30.333103179932, y=-674.09722900391, z=32.33805847168, h=0.0},
  {x=1270.7135009766, y=-1732.7083740234, z=52.04536819458, h=0.0},
  {x=30.516819000244, y=6604.0004882813, z=32.449085235596, h=0.0},
  {x=-550.20428466797, y=664.56500244141, z=145.16401672363, h=0.0},
  {x=815.37866210938, y=-2141.8317871094, z=28.912273406982, h=0.0},
  {x=-41.702621459961, y=-1076.9846191406, z=26.774045944214, h=0.0},

}

vehicles = {}
garageSelected = { {x=nil, y=nil, z=nil, h=nil}, }
garageSelectedGuardar = { {x=nil, y=nil, z=nil, h=nil}, }
selectedPage = 0

lang_string = {
menu2 = "Retirar veículos",
menu3 = "Fechar",
menu4 = "Veículos",
menu5 = "Opções",
menu6 = "Retirar Veículo",
menu7 = "Voltar",
menu8 = "Pressiona ~g~E~s~ para abrires o menu",
menu9 = "Vender Veículo",
menu10 = "Pression ~g~E~s~ para venderes o veículo em 50% do preço de compra",
menu11 = "Atualize o Veículo",
menu12 = "Avançar",
menu13 = "Pressiona ~g~E~s~ para guardares carro",
state1 = "Retirar veículo",
state2 = "Colocar dentro",
text1 = "A área está cheia",
text2 = "Este veículo não está na garagem",
text3 = "Retirar veículo",
text4 = "Este veículo não é teu",
text5 = "Veículo guardado",
text6 = "Nenhum veículo presente",
text7 = "Veículo vendido",
text8 = "Veículo comprado",
text9 = "Dinheiro insuficiente",
text10 = "Veículo atualizado"
}
--[[Functions]]--

function vRPgt.spawnGarageVehicle(vtype, name, vehicle_plate, vehicle_colorprimary, vehicle_colorsecondary, vehicle_pearlescentcolor, vehicle_wheelcolor, vehicle_plateindex, vehicle_neoncolor1, vehicle_neoncolor2, vehicle_neoncolor3, vehicle_windowtint, vehicle_wheeltype, vehicle_mods0, vehicle_mods1, vehicle_mods2, vehicle_mods3, vehicle_mods4, vehicle_mods5, vehicle_mods6, vehicle_mods7, vehicle_mods8, vehicle_mods9, vehicle_mods10, vehicle_mods11, vehicle_mods12, vehicle_mods13, vehicle_mods14, vehicle_mods15, vehicle_mods16, vehicle_turbo, vehicle_tiresmoke, vehicle_xenon, vehicle_mods23, vehicle_mods24, vehicle_neon0, vehicle_neon1, vehicle_neon2, vehicle_neon3, vehicle_bulletproof, vehicle_smokecolor1, vehicle_smokecolor2, vehicle_smokecolor3, vehicle_modvariation) -- vtype is the vehicle type (one vehicle per type allowed at the same time)

  local vehicle = vehicles[vtype]
  if vehicle and IsVehicleDriveable(vehicle[3]) then -- precheck if vehicle is undriveable
    -- despawn vehicle
    SetVehicleHasBeenOwnedByPlayer(vehicle[3],false)
    Citizen.InvokeNative(0xAD738C3085FE7E11, vehicle[3], false, true) -- set not as mission entity
    SetVehicleAsNoLongerNeeded(Citizen.PointerValueIntInitialized(vehicle[3]))
    Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle[3]))
	TriggerEvent("vrp_garages:setVehicle", vtype, nil)
  end

  vehicle = vehicles[vtype]
  if vehicle == nil then
    -- load vehicle model
    local mhash = GetHashKey(name)

    local i = 0
    while not HasModelLoaded(mhash) and i < 10000 do
      RequestModel(mhash)
      Citizen.Wait(10)
      i = i+1
    end

    -- spawn car
    if HasModelLoaded(mhash) then
      local x,y,z = vRP.getPosition({})
      local nveh = CreateVehicle(mhash, x,y,z+0.5, GetEntityHeading(GetPlayerPed(-1)), true, false) -- added player heading
      SetVehicleOnGroundProperly(nveh)
      SetEntityInvincible(nveh,false)
      SetPedIntoVehicle(GetPlayerPed(-1),nveh,-1) -- put player inside
      SetVehicleNumberPlateText(nveh, "P " .. vRP.getRegistrationNumber({}))
      Citizen.InvokeNative(0xAD738C3085FE7E11, nveh, true, true) -- set as mission entity
      SetVehicleHasBeenOwnedByPlayer(nveh,true)
	  vehicle_migration = false
      if not vehicle_migration then
        local nid = NetworkGetNetworkIdFromEntity(nveh)
        SetNetworkIdCanMigrate(nid,false)
      end

	  TriggerEvent("vrp_garages:setVehicle", vtype, {vtype,name,nveh})

      SetModelAsNoLongerNeeded(mhash)
	  
	  --grabbing customization
      local plate = plate
      local primarycolor = tonumber(vehicle_colorprimary)
      local secondarycolor = tonumber(vehicle_colorsecondary)
      local pearlescentcolor = vehicle_pearlescentcolor
      local wheelcolor = vehicle_wheelcolor
      local plateindex = tonumber(vehicle_plateindex)
      local neoncolor = {vehicle_neoncolor1,vehicle_neoncolor2,vehicle_neoncolor3}
      local windowtint = vehicle_windowtint
      local wheeltype = tonumber(vehicle_wheeltype)
      local mods0 = tonumber(vehicle_mods0)
      local mods1 = tonumber(vehicle_mods1)
      local mods2 = tonumber(vehicle_mods2)
      local mods3 = tonumber(vehicle_mods3)
      local mods4 = tonumber(vehicle_mods4)
      local mods5 = tonumber(vehicle_mods5)
      local mods6 = tonumber(vehicle_mods6)
      local mods7 = tonumber(vehicle_mods7)
      local mods8 = tonumber(vehicle_mods8)
      local mods9 = tonumber(vehicle_mods9)
      local mods10 = tonumber(vehicle_mods10)
      local mods11 = tonumber(vehicle_mods11)
      local mods12 = tonumber(vehicle_mods12)
      local mods13 = tonumber(vehicle_mods13)
      local mods14 = tonumber(vehicle_mods14)
      local mods15 = tonumber(vehicle_mods15)
      local mods16 = tonumber(vehicle_mods16)
      local turbo = vehicle_turbo
      local tiresmoke = vehicle_tiresmoke
      local xenon = vehicle_xenon
      local mods23 = tonumber(vehicle_mods23)
      local mods24 = tonumber(vehicle_mods24)
      local neon0 = vehicle_neon0
      local neon1 = vehicle_neon1
      local neon2 = vehicle_neon2
      local neon3 = vehicle_neon3
      local bulletproof = vehicle_bulletproof
      local smokecolor1 = vehicle_smokecolor1
      local smokecolor2 = vehicle_smokecolor2
      local smokecolor3 = vehicle_smokecolor3
      local variation = vehicle_modvariation
	  
	  --setting customization
      SetVehicleColours(nveh, primarycolor, secondarycolor)
      SetVehicleExtraColours(nveh, tonumber(pearlescentcolor), tonumber(wheelcolor))
      SetVehicleNumberPlateTextIndex(nveh,plateindex)
      SetVehicleNeonLightsColour(nveh,tonumber(neoncolor[1]),tonumber(neoncolor[2]),tonumber(neoncolor[3]))
      SetVehicleTyreSmokeColor(nveh,tonumber(smokecolor1),tonumber(smokecolor2),tonumber(smokecolor3))
      SetVehicleModKit(nveh,0)
      SetVehicleMod(nveh, 0, mods0)
      SetVehicleMod(nveh, 1, mods1)
      SetVehicleMod(nveh, 2, mods2)
      SetVehicleMod(nveh, 3, mods3)
      SetVehicleMod(nveh, 4, mods4)
      SetVehicleMod(nveh, 5, mods5)
      SetVehicleMod(nveh, 6, mods6)
      SetVehicleMod(nveh, 7, mods7)
      SetVehicleMod(nveh, 8, mods8)
      SetVehicleMod(nveh, 9, mods9)
      SetVehicleMod(nveh, 10, mods10)
      SetVehicleMod(nveh, 11, mods11)
      SetVehicleMod(nveh, 12, mods12)
      SetVehicleMod(nveh, 13, mods13)
      SetVehicleMod(nveh, 14, mods14)
      SetVehicleMod(nveh, 15, mods15)
      SetVehicleMod(nveh, 16, mods16)
      if turbo == "on" then
        ToggleVehicleMod(nveh, 18, true)
      else          
        ToggleVehicleMod(nveh, 18, false)
      end
      if tiresmoke == "on" then
        ToggleVehicleMod(nveh, 20, true)
      else          
        ToggleVehicleMod(nveh, 20, false)
      end
      if xenon == "on" then
        ToggleVehicleMod(nveh, 22, true)
      else          
        ToggleVehicleMod(nveh, 22, false)
      end
		SetVehicleWheelType(nveh, tonumber(wheeltype))
      SetVehicleMod(nveh, 23, mods23)
      SetVehicleMod(nveh, 24, mods24)
      if neon0 == "on" then
        SetVehicleNeonLightEnabled(nveh,0, true)
      else
        SetVehicleNeonLightEnabled(nveh,0, false)
      end
      if neon1 == "on" then
        SetVehicleNeonLightEnabled(nveh,1, true)
      else
        SetVehicleNeonLightEnabled(nveh,1, false)
      end
      if neon2 == "on" then
        SetVehicleNeonLightEnabled(nveh,2, true)
      else
        SetVehicleNeonLightEnabled(nveh,2, false)
      end
      if neon3 == "on" then
        SetVehicleNeonLightEnabled(nveh,3, true)
      else
        SetVehicleNeonLightEnabled(nveh,3, false)
      end
      if bulletproof == "on" then
        SetVehicleTyresCanBurst(nveh, false)
      else
        SetVehicleTyresCanBurst(nveh, true)
      end
      --if variation == "on" then
      --  SetVehicleModVariation(nveh,23)
      --else
      --  SetVehicleModVariation(nveh,23, false)
      --end
      SetVehicleWindowTint(nveh,tonumber(windowtint))
    end
  else
    vRP.notify({"Só podes ter um "..vtype.." veículo de fora."})
  end
end

function vRPgt.spawnBoughtVehicle(vtype, name)

  local vehicle = vehicles[vtype]
  if vehicle then -- precheck if vehicle is undriveable
    -- despawn vehicle
    SetVehicleHasBeenOwnedByPlayer(vehicle[3],false)
    Citizen.InvokeNative(0xAD738C3085FE7E11, vehicle[3], false, true) -- set not as mission entity
    SetVehicleAsNoLongerNeeded(Citizen.PointerValueIntInitialized(vehicle[3]))
    Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle[3]))
	TriggerEvent("vrp_garages:setVehicle", vtype, nil)
  end

  vehicle = vehicles[vtype]
  if vehicle == nil then
    -- load vehicle model
    local mhash = GetHashKey(name)

    local i = 0
    while not HasModelLoaded(mhash) and i < 10000 do
      RequestModel(mhash)
      Citizen.Wait(10)
      i = i+1
    end

    -- spawn car
    if HasModelLoaded(mhash) then
      local x,y,z = vRP.getPosition({})
      local nveh = CreateVehicle(mhash, x,y,z+0.5, GetEntityHeading(GetPlayerPed(-1)), true, false) -- added player heading
      SetVehicleOnGroundProperly(nveh)
      SetEntityInvincible(nveh,false)
      SetPedIntoVehicle(GetPlayerPed(-1),nveh,-1) -- put player inside
      SetVehicleNumberPlateText(nveh, "P " .. vRP.getRegistrationNumber({}))
      Citizen.InvokeNative(0xAD738C3085FE7E11, nveh, true, true) -- set as mission entity
      SetVehicleHasBeenOwnedByPlayer(nveh,true)
	  vehicle_migration = false
      if not vehicle_migration then
        local nid = NetworkGetNetworkIdFromEntity(nveh)
        SetNetworkIdCanMigrate(nid,false)
      end

	  TriggerEvent("vrp_garages:setVehicle", vtype, {vtype,name,nveh})

      SetModelAsNoLongerNeeded(mhash)
    end
  else
    vRP.notify({"Só podes ter um "..vtype.." veículo de fora."})
  end
end

function vRPgt.despawnGarageVehicle(vtype,max_range)
  local vehicle = vehicles[vtype]
  if vehicle then
    local x,y,z = table.unpack(GetEntityCoords(vehicle[3],true))
    local px,py,pz = vRP.getPosition()

    if GetDistanceBetweenCoords(x,y,z,px,py,pz,true) < max_range then -- check distance with the vehicule
      -- remove vehicle
      SetVehicleHasBeenOwnedByPlayer(vehicle[3],false)
      Citizen.InvokeNative(0xAD738C3085FE7E11, vehicle[3], false, true) -- set not as mission entity
      SetVehicleAsNoLongerNeeded(Citizen.PointerValueIntInitialized(vehicle[3]))
      Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle[3]))
	  TriggerEvent("vrp_garages:setVehicle", vtype, nil)
      vRP.notify({"~g~Veículo Guardado."})
    else
      vRP.notify({"~r~Muito longe do veículo."})
    end
  else
  vRP.notify({"~r~Não tens nenhum veículo."})
  end
end

function MenuGarage()
    ped = GetPlayerPed(-1)
	selectedPage = 0
    MenuTitle = "Garagem"
    ClearMenu()
    Menu.addButton(lang_string.menu2,"ListVehicle",selectedPage)
    Menu.addButton(lang_string.menu3,"CloseMenu",nil) 
end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    for _, garageguardar in pairs(garagesguardar) do
      DrawMarker(36, garageguardar.x, garageguardar.y, garageguardar.z, 2, 2, 2, 2, 2, 2, 2.001, 2.0001, 2.5001, 2, 235, 36, 21, 2, 2, 2, 2)
      if GetDistanceBetweenCoords(garageguardar.x, garageguardar.y, garageguardar.z, GetEntityCoords(LocalPed())) < 3 then
        ply_drawTxt(lang_string.menu13,0,1,0.5,0.8,0.6,255,255,255,255)
        if IsControlJustPressed(1, 86) then
          garageSelectedGuardar.x = garageguardar.x
          garageSelectedGuardar.y = garageguardar.y
          garageSelectedGuardar.z = garageguardar.z
          MenuGuardar()
        end
      end
    end
  end
end)

function MenuGuardar()
  Citizen.CreateThread(function()
    local ped = GetPlayerPed(-1)
    local caissei = GetVehiclePedIsUsing(ped)
    SetEntityAsMissionEntity(caissei, true, true)
    local plate = GetVehicleNumberPlateText(caissei)
	local vtype = "car"
	if IsThisModelABike(GetEntityModel(caissei)) then
		vtype = "bike"
	end
    --if DoesEntityExist(caissei) then
	if DoesEntityExist(caissei) then
      TriggerServerEvent('ply_garages:CheckForVeh', plate, vehicles[vtype][2], vtype)
    else
      drawNotification(lang_string.text6)
    end   
  end)
  CloseMenu()
end

function ListVehicle(page)
    ped = GetPlayerPed(-1)
	selectedPage = page
    MenuTitle = lang_string.menu4
    ClearMenu()
	local count = 0
    for ind, value in pairs(GVEHICLES) do
	  if ((count >= (page*10)) and (count < ((page*10)+10))) then
        Menu.addButton(tostring(value.vehicle_name), "OptionVehicle", value.vehicle_name)
	  end
	  count = count + 1
    end   
    Menu.addButton(lang_string.menu12,"ListVehicle",page+1)
	if page == 0 then
      Menu.addButton(lang_string.menu7,"MenuGarage",nil)
	else
      Menu.addButton(lang_string.menu7,"ListVehicle",page-1)
	end
end

function OptionVehicle(vehID)
  local vehID = vehID
    MenuTitle = "Opções"
    ClearMenu()
    Menu.addButton(lang_string.menu6, "SpawnVehicle", vehID)
    Menu.addButton(lang_string.menu7, "ListVehicle", selectedPage)
end

function SpawnVehicle(vehID)
  local vehID = vehID
  TriggerServerEvent('ply_garages:CheckForSpawnVeh', vehID)
  CloseMenu()
end


function drawNotification(text)
  SetNotificationTextEntry("STRING")
  AddTextComponentString(text)
  DrawNotification(false, false)
end

function CloseMenu()
    Menu.hidden = true    
    TriggerServerEvent("ply_garages:CheckGarageForVeh")
end

function LocalPed()
  return GetPlayerPed(-1)
end

function IsPlayerInRangeOfGarage()
  return inrangeofgarage
end

function Chat(debugg)
    TriggerEvent("chatMessage", '', { 0, 0x99, 255 }, tostring(debugg))
end

function ply_drawTxt(text,font,centre,x,y,scale,r,g,b,a)
  SetTextFont(font)
  SetTextProportional(0)
  SetTextScale(scale, scale)
  SetTextColour(r, g, b, a)
  SetTextDropShadow(0, 0, 0, 0,255)
  SetTextEdge(1, 0, 0, 0, 255)
  SetTextDropShadow()
  SetTextOutline()
  SetTextCentre(centre)
  SetTextEntry("STRING")
  AddTextComponentString(text)
  DrawText(x , y)
end

--[[Citizen]]--

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    for _, garage in pairs(garages) do
      DrawMarker(36, garage.x, garage.y, garage.z, 2, 2, 2, 2, 2, 2, 2.001, 2.0001, 2.5001, 2, 17, 217, 8, 2, 2, 2, 2)
      if GetDistanceBetweenCoords(garage.x, garage.y, garage.z, GetEntityCoords(LocalPed())) < 3 then
        ply_drawTxt(lang_string.menu8,0,1,0.5,0.8,0.6,255,255,255,255)
        if IsControlJustPressed(1, 86) then
          garageSelected.x = garage.x
          garageSelected.y = garage.y
          garageSelected.z = garage.z
          MenuGarage()
          Menu.hidden = not Menu.hidden 
        end
        Menu.renderGUI() 
      end
    end
  end
end)

Citizen.CreateThread(function()
  while true do
    local near = false
    Citizen.Wait(0)
    for _, garage in pairs(garages) do    
      if (GetDistanceBetweenCoords(garage.x, garage.y, garage.z, GetEntityCoords(LocalPed())) < 3 and near ~= true) then 
        near = true             
      end
    end
    if near == false then 
      Menu.hidden = true
    end
  end
end)

Citizen.CreateThread(function()
    for _, item in pairs(garages) do
    item.blip = AddBlipForCoord(item.x, item.y, item.z)
    SetBlipSprite(item.blip, item.id)
    SetBlipAsShortRange(item.blip, true)
    SetBlipColour(item.blip, item.colour)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(item.name)
    EndTextCommandSetBlipName(item.blip)
    end
end)

--[[Events]]--

RegisterNetEvent('vrp_garages:setVehicle')
AddEventHandler('vrp_garages:setVehicle', function(vtype, vehicle)
	vehicles[vtype] = vehicle
end)

RegisterNetEvent('ply_garages:addAptGarage')
AddEventHandler('ply_garages:addAptGarage', function(gx,gy,gz,gh)
local alreadyExists = false
for _, garage in pairs(garages) do
	if garage.x == gx and garage.y == gy then
		alreadyExists = true
	end
end
if not alreadyExists then
	table.insert(garages, #garages + 1, {name="Apartment Garage", colour=2, id=357, x=gx, y=gy, z=gz, h=gh})
end
end)

RegisterNetEvent('ply_garages:getVehicles')
AddEventHandler("ply_garages:getVehicles", function(THEVEHICLES)
    GVEHICLES = {}
    GVEHICLES = THEVEHICLES
end)

AddEventHandler("playerSpawned", function()
    TriggerServerEvent("ply_garages:CheckGarageForVeh")
    TriggerServerEvent("ply_garages:CheckForAptGarages")
end)
