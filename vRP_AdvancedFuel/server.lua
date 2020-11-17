local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
MySQL = module("vrp_mysql", "MySQL")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_AdvancedFuel")

vRPbf = {}
Tunnel.bindInterface("vRP_AdvancedFuel",vRPbf)
Proxy.addInterface("vRP_AdvancedFuel",vRPbf)

local cfg = module("vRP_AdvancedFuel", "cfg/business")
local business = cfg.businessloc
local business1 = cfg.businesscomprar

local players = {}
local serverEssenceArray = {}
local StationsPrice = {}

MySQL.createCommand("vRP/bombagasolina_tables","CREATE TABLE IF NOT EXISTS vrp_bombagasolina_table(id INTEGER AUTO_INCREMENT, fuel INTEGER NOT NULL DEFAULT 0, bmoney INTEGER NOT NULL DEFAULT 0, data TEXT NOT NULL DEFAULT '', bombaDono TEXT NOT NULL DEFAULT '', bombaDonoID INTEGER NOT NULL DEFAULT 0, PRIMARY KEY (id)); INSERT IGNORE INTO vrp_bombagasolina_table(id,fuel,bmoney) VALUES(1,1000,50000);")
MySQL.createCommand("vRP/get_gota_bombagasolina","SELECT * FROM vrp_bombagasolina_table WHERE id = @id")
MySQL.createCommand("vRP/set_gota_bombagasolina","UPDATE vrp_bombagasolina_table SET fuel=@fuel WHERE id = @id")
MySQL.createCommand("vRP/update_gota_bombagasolina","UPDATE vrp_bombagasolina_table SET fuel=fuel+@fuel WHERE id = @id")
MySQL.createCommand("vRP/get_dinheiro_bombagasolina","SELECT * FROM vrp_bombagasolina_table WHERE id = @id")
MySQL.createCommand("vRP/set_dinheiro_bombagasolina","UPDATE vrp_bombagasolina_table SET bmoney=@bmoney WHERE id = @id")
MySQL.createCommand("vRP/update_dinheiro_bombagasolina","UPDATE vrp_bombagasolina_table SET bmoney=bmoney+@bmoney WHERE id = @id")
MySQL.createCommand("vRP/update_bombagasolinashopdata","UPDATE vrp_bombagasolina_table SET data=@data WHERE id = @id")
MySQL.createCommand("vRP/conseguir_bombas", "SELECT * FROM vrp_bombagasolina_table WHERE id = @id")
MySQL.createCommand("vRP/compra_bombas", "UPDATE vrp_bombagasolina_table SET bombaDono = @bombaDono, bombaDonoID = @bombaDonoID WHERE id = @id")


MySQL.query("vRP/bombagasolina_tables")

function parseInt(v)
	local n = tonumber(v)
	if n == nil then 
		return 0
	else
		return math.floor(n)
	end
end


function insertBusinessData(user_id, line)
	if user_id ~= nil then
		MySQL.query("vRP/get_gota_bombagasolina", {id = 1}, function(rows, affected)
			if #rows > 0 then
				for k,v in ipairs(rows) do
					local ndata = v.data
					if ndata ~= nil then
						local dataupdate = ndata..line.."<br />"
						MySQL.query("vRP/update_bombagasolinashopdata", {data = dataupdate, id = 1})
					else
						local dataupdate = line.."<br />"
						MySQL.query("vRP/update_bombagasolinashopdata", {data = dataupdate, id = 1})
					end
				end
			end
		end)
	end
end

--[[function updateFuel(percent)
	local id = vRP.getUsersByPermission("bombas.emprego")
	if #id > 0 then
		for k, v in pairs(id) do
			MySQL.execute("vRP/update_dinheiro_bombagasolina", {bmoney = percent,id = v})
		end
	end
end]]

RegisterServerEvent("essence:addPlayer")
AddEventHandler("essence:addPlayer", function()
	local _source = source
	TriggerClientEvent("essence:sendPrice", source, StationsPrice)
	table.insert(players,_source)
end)

AddEventHandler("playerDropped", function(reason)
	local _source = source
	local newPlayers = {}
	
	for _,k in pairs(players) do
		if(k~=_source) then
			table.insert(newPlayers, k)
		end
	end

	players = {}
	players = newPlayers
end)



RegisterServerEvent("essence:playerSpawned")
AddEventHandler("essence:playerSpawned", function()
	local _source = source
	SetTimeout(2000, function()
		TriggerClientEvent("essence:sendPrice", _source, StationsPrice)
		TriggerClientEvent("essence:sendEssence", _source, serverEssenceArray)
	end)
end)


RegisterServerEvent("essence:setToAllPlayerEscense")
AddEventHandler("essence:setToAllPlayerEscense", function(essence, vplate, vmodel)
	local _source = source
	local bool, ind = searchByModelAndPlate(vplate, vmodel)
	if(bool and ind ~= nil) then
		serverEssenceArray[ind].es = essence
	else
		if(vplate ~=nil and vmodel~=nil and essence ~=nil) then
			table.insert(serverEssenceArray,{plate=vplate,model=vmodel,es=essence})
		end
	end

	TriggerClientEvent('essence:syncWithAllPlayers', -1, essence, vplate, vmodel)
end)


RegisterServerEvent("essence:buy")
AddEventHandler("essence:buy", function(response, index,e)
local player = source

	local price = StationsPrice[index]

	if(e) then
		price = index
	end

	local user_id = vRP.getUserId({player})
	if user_id ~= nil then
		MySQL.query("vRP/get_gota_bombagasolina", {id = 1}, function(rows, affected)
			if #rows > 0 then
				for k,v in ipairs(rows) do
					local fuel = v.fuel
					vRP.prompt({player,"Combustivel: "..fuel.." | Quantia para Retirar (MIN 1) (MAX 50):","",function(player,response)
						if response ~= nil and response ~= "" then
							if parseInt(response) > 1 or parseInt(response) > 50 then
								response = parseInt(response)
								if response > fuel then
									vRPclient.notify(player,{"~y~SISTEMA: ~w~Não existe essa quantidade para tirar."})
								else
								local toPay = round(response*price,2)
									if(vRP.tryPayment({user_id,toPay})) then
									local percentagem = toPay*20/100
									MySQL.query("vRP/update_money_businessfuel", {bmoney = percentagem, id = 1})
											--local percent = 100
											--updateFuel(percent)
											TriggerClientEvent("essence:hasBuying", player, response)
									local fuelupdate = fuel-response
									MySQL.query("vRP/set_gota_bombagasolina", {fuel = fuelupdate, id = 1})
									MySQL.query("vRP/get_gota_bombagasolina", {id = 1}, function(rows, affected)
										if #rows > 0 then
											for k,v in ipairs(rows) do
												local newfuel = v.fuel
												if newfuel ~= fuel then
													vRPclient.notify(player,{"~y~SISTEMA: ~w~Você retirou "..response.."litros."})
													insertBusinessData(user_id, "[ID "..user_id.."] precisava desta quantidade de combustivel $"..response.."")
												else
													vRPclient.notify(player,{"~y~SISTEMA: ~w~Algo de errado não está certo."})
												end
											end
										else
											vRPclient.notify(player,{"~y~SISTEMA: ~w~Não foi possível encontrar dados da Empresa."})
										end
									end)
									else
									TriggerClientEvent("showErrorNotif", player, "Dinheiro insuficiente.")	
								end								
							end
							elseif parseInt(response) < 1 or parseInt(response) > 50 then
								response = 0
								vRPclient.notify(player,{"~y~SISTEMA: ~w~Não aceitamos valores núlos ou negativos."})
							else
								response = 0
								vRPclient.notify(player,{"~y~SISTEMA: ~w~Não aceitamos valores núlos ou negativos."})
							end
						else
							vRPclient.notify(player,{"~y~SISTEMA: ~w~Dados inválidos ou vazios."})
						end
				    end})
				end
			end
		end)
	end
end)

RegisterServerEvent("essence:requestPrice")
AddEventHandler("essence:requestPrice",function()
	TriggerClientEvent("essence:sendPrice", source, StationsPrice)
end)


RegisterServerEvent("vehicule:getFuel")
AddEventHandler("vehicule:getFuel", function(plate,model)
	local _source = source
	local bool, ind = searchByModelAndPlate(plate, model)

	if(bool) then
		TriggerClientEvent("vehicule:sendFuel", _source, 1, serverEssenceArray[ind].es)
	else
		TriggerClientEvent("vehicule:sendFuel", _source, 0, 0)
	end
end)



RegisterServerEvent("advancedFuel:setEssence_s")
AddEventHandler("advancedFuel:setEssence_s", function(percent, vplate, vmodel)
	local bool, ind = searchByModelAndPlate(vplate, vmodel)

	local percentToEs = (percent/100)*0.142

	if(bool) then
		serverEssenceArray[ind].es = percentToEs
	else
		table.insert(serverEssenceArray,{plate=vplate,model=vmodel,es=percentToEs})
	end
end)

RegisterServerEvent("essence:buyCan")
AddEventHandler("essence:buyCan", function()
	local _source = source

	local toPay = petrolCanPrice
	local user_id = vRP.getUserId({_source})
	if(vRP.tryPayment({user_id,toPay})) then
		TriggerClientEvent("essence:buyCan", _source)
	else
		TriggerClientEvent("showErrorNotif", _source, "Dinheiro insuficiente.")
	end
end)



function round(num, dec)
  local mult = 10^(dec or 0)
  return math.floor(num * mult + 0.5) / mult
end


function renderPrice()
    for i=0,34 do
        if(randomPrice) then
            StationsPrice[i] = round(math.random(),2) + math.random(2,3) + .009
        else
        	StationsPrice[i] = price
        end
    end

    print("launched")
end


renderPrice()

function searchByModelAndPlate(plate, model)

	for i,k in pairs(serverEssenceArray) do
		if(k.plate == plate and k.model == model) then
			return true, i
		end
	end

	return false, -1
end

local function ch_depositarfuel(player,choice)
	local user_id = vRP.getUserId({player})
	if user_id ~= nil then
		local fuel = vRP.getInventoryItemAmount({user_id,fuel}) 
		local maxfuel = 1000
		vRP.prompt({player,"Quantidade: "..wallet.." | Quantia para Depositar:","",function(player,response)
			if response ~= nil and response ~= "" then
				if parseInt(response) > 1 and fuel+response <= maxfuel  then
					response = parseInt(response)
					if(vRP.tryGetInventoryItem({user_id,fuel,response,true})) then
						MySQL.query("vRP/update_gota_bombagasolina", {fuel = response, id = 1})
						local newfuel = vRP.getInventoryItemAmount({user_id,fuel})
						if newfuel ~= fuel then
							vRPclient.notify(player,{"~y~SISTEMA: ~w~Você depositou $"..response.."."})
							insertBusinessData(user_id, "[ID "..user_id.."] depositou esta quantidade de combustivel $"..response.."")
						else
							vRPclient.notify(player,{"~y~SISTEMA: ~w~Algo de errado não está certo."})
						end
					else
						vRPclient.notify(player,{"~y~SISTEMA: ~w~Não existe esse valor disponível para deposito."})
					end
				elseif parseInt(response) < 1 then
					response = 0
					vRPclient.notify(player,{"~y~SISTEMA: ~w~Não aceitamos valores núlos ou negativos."})
				else
					response = 0
					vRPclient.notify(player,{"~y~SISTEMA: ~w~Não aceitamos valores núlos ou negativos."})
				end
			else
				vRPclient.notify(player,{"~y~SISTEMA: ~w~Dados inválidos ou vazios ou ultrapassou os 1000 litros."})
			end
	    end})
	end
end

local function ch_consultarfuel(player,choice)
	local user_id = vRP.getUserId({player})
	if user_id ~= nil then
		MySQL.query("vRP/get_gota_bombagasolina", {id = 1}, function(rows, affected)
			if #rows > 0 then
				for k,v in ipairs(rows) do
					local fuel = v.fuel
					vRP.buildMenu({"searchbusiness", {player = player}, function(menu)
						menu.name = "Combustivel"
						menu["Combustivel disponível"] = {nil,"Combustivel disponível: $"..fuel.."."}
						vRP.openMenu({player,menu})
					end})
				end
			else
				vRPclient.notify(player,{"~y~SISTEMA: ~w~Não foi possível encontrar dados da Empresa."})
			end
		end)
	end
end

local function ch_consultarsaldo(player,choice)
	local user_id = vRP.getUserId({player})
	if user_id ~= nil then
		MySQL.query("vRP/get_dinheiro_bombagasolina", {id = 1}, function(rows, affected)
			if #rows > 0 then
				for k,v in ipairs(rows) do
					local saldo = v.bmoney
					vRP.buildMenu({"searchbusiness", {player = player}, function(menu)
						menu.name = "Saldo"
						menu["Saldo disponível"] = {nil,"Saldo disponível: "..saldo.."€."}
						vRP.openMenu({player,menu})
					end})
				end
			else
				vRPclient.notify(player,{"~y~SISTEMA: ~w~Não foi possível encontrar dados da Empresa."})
			end
		end)
	end
end

local player_lists = {}
local function ch_consultardata(player,choice)
	local user_id = vRP.getUserId({player})
	if user_id ~= nil then
		if player_lists[player] then
			player_lists[player] = nil
			vRPclient.removeDiv(player,{"business_pc"})
		else
			MySQL.query("vRP/get_gota_bombagasolina", {id = 1}, function(rows, affected)
				if #rows > 0 then
					for k,v in ipairs(rows) do
						local data = v.data
						player_lists[player] = true
						vRPclient.setDiv(player,{"business_pc",".div_business_pc{ background-color: rgba(0,0,0,0.75); color: white; font-weight: bold; width: 500px; padding: 10px; margin: auto; margin-top: 150px; }",data})
					end
				else
					vRPclient.notify(player,{"~y~SISTEMA: ~w~Não foi possível encontrar dados da Empresa."})
				end
			end)
		end
	end
end

local function ch_retirarsaldo(player,choice)
	local user_id = vRP.getUserId({player})
	if user_id ~= nil then
		MySQL.query("vRP/get_dinheiro_bombagasolina", {id = 1}, function(rows, affected)
			if #rows > 0 then
				for k,v in ipairs(rows) do
					local saldo = v.bmoney
					vRP.prompt({player,"Saldo: "..saldo.." | Quantia para Retirar:","",function(player,response)
						if response ~= nil and response ~= "" then
							if parseInt(response) > 1 then
								response = parseInt(response)
								if response > saldo then
									vRPclient.notify(player,{"~y~SISTEMA: ~w~Não existe esse valor disponível para saque."})
								else
									local saldoupdate = saldo-response
									MySQL.query("vRP/set_dinheiro_bombagasolina", {bmoney = saldoupdate, id = 1})
									MySQL.query("vRP/get_dinheiro_bombagasolina", {id = 1}, function(rows, affected)
										if #rows > 0 then
											for k,v in ipairs(rows) do
												local newsaldo = v.bmoney
												if newsaldo ~= saldo then
													vRP.giveMoney({user_id,response})
													vRPclient.notify(player,{"~y~SISTEMA: ~w~Você retirou $"..response.."."})
													insertBusinessData(user_id, "[ID "..user_id.."] retirou $"..response.."")
												else
													vRPclient.notify(player,{"~y~SISTEMA: ~w~Algo de errado não está certo."})
												end
											end
										else
											vRPclient.notify(player,{"~y~SISTEMA: ~w~Não foi possível encontrar dados da Empresa."})
										end
									end)
								end
							elseif parseInt(response) < 1 then
								response = 0
								vRPclient.notify(player,{"~y~SISTEMA: ~w~Não aceitamos valores núlos ou negativos."})
							else
								response = 0
								vRPclient.notify(player,{"~y~SISTEMA: ~w~Não aceitamos valores núlos ou negativos."})
							end
						else
							vRPclient.notify(player,{"~y~SISTEMA: ~w~Dados inválidos ou vazios."})
						end
				    end})
				end
			end
		end)
	end
end

local function ch_depositarsaldo(player,choice)
	local user_id = vRP.getUserId({player})
	if user_id ~= nil then
		local wallet = vRP.getMoney({user_id})
		vRP.prompt({player,"Carteira: "..wallet.." | Quantia para Depositar:","",function(player,response)
			if response ~= nil and response ~= "" then
				if parseInt(response) > 1 then
					response = parseInt(response)
					if(vRP.tryPayment({user_id,response})) then
						MySQL.query("vRP/update_dinheiro_bombagasolina", {bmoney = response, id = 1})
						local newwallet = vRP.getMoney({user_id})
						if newwallet ~= wallet then
							vRPclient.notify(player,{"~y~SISTEMA: ~w~Você depositou $"..response.."."})
							insertBusinessData(user_id, "[ID "..user_id.."] depositou $"..response.."")
						else
							vRPclient.notify(player,{"~y~SISTEMA: ~w~Algo de errado não está certo."})
						end
					else
						vRPclient.notify(player,{"~y~SISTEMA: ~w~Não existe esse valor disponível para deposito."})
					end
				elseif parseInt(response) < 1 then
					response = 0
					vRPclient.notify(player,{"~y~SISTEMA: ~w~Não aceitamos valores núlos ou negativos."})
				else
					response = 0
					vRPclient.notify(player,{"~y~SISTEMA: ~w~Não aceitamos valores núlos ou negativos."})
				end
			else
				vRPclient.notify(player,{"~y~SISTEMA: ~w~Dados inválidos ou vazios."})
			end
	    end})
	end
end

local function ch_businessMenu(player, choice)
	vRP.buildMenu({"fuelempresa", {player = player}, function(menu)
		menu.name = cfg.business_title
		local user_id = vRP.getUserId({player})
		menu["Consultar Dinheiro"] = {ch_consultarsaldo,"Ver o Dinheiro da Empresa"}
		menu["Consultar Combustivel"] = {ch_consultarfuel,"Ver o combustivel da Empresa"}
		menu["Consultar Histórico"] = {ch_consultardata,"Ver o Histórico da Empresa"}
		vRP.openMenu({player,menu})
	end})
end

local function build_client_businesscenter(source)
	local user_id = vRP.getUserId({source})
	if user_id ~= nil then
		for k,v in pairs(business) do
			local x,y,z = table.unpack(v)

			local business_enter = function(source)
				local user_id = vRP.getUserId({source})
				if user_id ~= nil and vRP.hasPermission({user_id,cfg.permission}) then
					local menudata = {
						name=cfg.business_title
					}
					menudata["Depositar Combustivel"] = {ch_depositarfuel}
					menudata["Depositar Dinheiro"] = {ch_depositarsaldo}
					menudata["Retirar Dinheiro"] = {ch_retirarsaldo}
					menudata["Consultar Dinheiro"] = {ch_consultarsaldo}
					menudata["Consultar Combustivel"] = {ch_consultarfuel}
					menudata["Consultar Histórico"] = {ch_consultardata}
					vRP.openMenu({source, menudata})
				end
			end

			local function business_leave(source)
				vRP.closeMenu({source})
			end

			--vRPclient.addBlip(source,{x,y,z,cfg.blipid,cfg.blipcolor,cfg.business_title})
			vRPclient.addMarker(source,{x,y,z-1,0.7,0.7,0.5,0,255,125,125,150})

			vRP.setArea({source,"vRP:fuelempresa"..k,x,y,z,1,1.5,business_enter,business_leave})
		end
	end
end

local function ch_comprarbomba(player,choice)
	local user_id = vRP.getUserId({player})
	if user_id ~= nil then
	MySQL.query("vRP/conseguir_bombas", {bombaID = bombaID}, function(rows, affected)
		if #rows > 0 then
			for i, v in pairs(rows) do
				if(v.bombaDono == "")then
					if(vRP.tryFullPayment({user_id, 5000000}))then
						vRP.addUserGroup(user_id,"bombasdono")
						vRPclient.notify(player, {"~w~[Bombas] ~g~Compraste ~r~As bombas da amadora por ~g~5000000€"})
						MySQL.query("vRP/compra_bombas", {bombaID = bombaID, bombaDono = GetPlayerName(player), bombaDonoID = user_id})
					else
						vRPclient.notify(player, {"~w~[Bombas] ~r~You don't have enough money!"})
					end
				else
					vRPclient.notify(player, {"~w~[Bombas] ~r~This business is already owned by ~g~"..v.bombaDono})
				end
			end
		end
	  end)
	end
end

local function build_client_comprar(source)
	local user_id = vRP.getUserId({source})
	if user_id ~= nil then
		for k,v in pairs(business1) do
			local x,y,z = table.unpack(v)
			local dono = v.bombaDono

			local business_enter1 = function(source)
				local user_id = vRP.getUserId({source})
				if user_id ~= nil and dono == "Nenhum" then
					local menudata = {
						name=cfg.business_title
					}
					menudata["Comprar Bomba"] = {ch_comprarbomba}
					vRP.openMenu({source, menudata})
				end
			end

			local function business_leave1(source)
				vRP.closeMenu({source})
			end

			vRPclient.addBlip(source,{x,y,z,cfg.blipid,cfg.blipcolor,cfg.business_title})
			vRPclient.addMarker(source,{x,y,z-1,0.7,0.7,0.5,0,255,125,125,150})

			vRP.setArea({source,"vRP:fuelempresa"..k,x,y,z,1,1.5,business_enter1,business_leave1})
		end
	end
end

AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
	if first_spawn then
		build_client_businesscenter(source)
	end
end)