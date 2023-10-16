ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('a_ems:revive')
AddEventHandler('a_ems:revive', function(target)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.addMoney(Config.ReviveReward)
	TriggerClientEvent('a_ems:revive', target)
end)

RegisterServerEvent('a_ems:heal')
AddEventHandler('a_ems:heal', function(target, type)
	TriggerClientEvent('a_ems:heal', target, type)
end)

TriggerEvent('esx_phone:registerNumber', 'ambulance', _U('alert_ambulance'), true, true)

TriggerEvent('esx_society:registerSociety', 'ambulance', 'Ambulance', 'society_ambulance', 'society_ambulance',
	'society_ambulance', { type = 'public' })

ESX.RegisterServerCallback('a_ems:removeItemsAfterRPDeath', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if Config.RemoveCashAfterRPDeath then
		if xPlayer.getMoney() > 0 then
			xPlayer.removeMoney(xPlayer.getMoney())
		end

		if xPlayer.getAccount('black_money').money > 0 then
			xPlayer.setAccountMoney('black_money', 0)
		end
	end

	if Config.RemoveItemsAfterRPDeath then
		for i = 1, #xPlayer.inventory, 1 do
			if xPlayer.inventory[i].count > 0 then
				xPlayer.setInventoryItem(xPlayer.inventory[i].name, 0)
			end
		end
	end

	local playerLoadout = {}
	if Config.RemoveWeaponsAfterRPDeath then
		for i = 1, #xPlayer.loadout, 1 do
			xPlayer.removeWeapon(xPlayer.loadout[i].name)
		end
	else -- save weapons & restore em' since
		for i = 1, #xPlayer.loadout, 1 do
			table.insert(playerLoadout, xPlayer.loadout[i])
		end

		-- give back wepaons after a couple of seconds
		Citizen.CreateThread(function()
			Citizen.Wait(5000)
			for i = 1, #playerLoadout, 1 do
				if playerLoadout[i].label ~= nil then
					xPlayer.addWeapon(playerLoadout[i].name, playerLoadout[i].ammo)
				end
			end
		end)
	end

	cb()
end)

if Config.EarlyRespawn and Config.EarlyRespawnFine then
	ESX.RegisterServerCallback('a_ems:checkBalance', function(source, cb)
		local xPlayer = ESX.GetPlayerFromId(source)
		local bankBalance = xPlayer.getAccount('bank').money
		local finePayable = false

		if bankBalance >= Config.EarlyRespawnFineAmount then
			finePayable = true
		else
			finePayable = false
		end

		cb(finePayable)
	end)

	ESX.RegisterServerCallback('a_ems:payFine', function(source, cb)
		local xPlayer = ESX.GetPlayerFromId(source)
		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('respawn_fine', Config.EarlyRespawnFineAmount))
		xPlayer.removeAccountMoney('bank', Config.EarlyRespawnFineAmount)
		cb()
	end)
end

ESX.RegisterServerCallback('a_ems:getItemAmount', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local qtty = xPlayer.getInventoryItem(item).count
	cb(qtty)
end)

RegisterServerEvent('a_ems:removeItem')
AddEventHandler('a_ems:removeItem', function(item)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeInventoryItem(item, 1)
	if item == 'bandage' then
		TriggerClientEvent('esx:showNotification', _source, _U('used_bandage'))
	elseif item == 'medikit' then
		TriggerClientEvent('esx:showNotification', _source, _U('used_medikit'))
	end
end)

RegisterServerEvent('a_ems:giveItem')
AddEventHandler('a_ems:giveItem', function(item)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local limit = xPlayer.getInventoryItem(item).limit
	local delta = 1
	local qtty = xPlayer.getInventoryItem(item).count
	if limit ~= -1 then
		delta = limit - qtty
	end
	if qtty < limit then
		xPlayer.addInventoryItem(item, delta)
	else
		TriggerClientEvent('esx:showNotification', _source, _U('max_item'))
	end
end)

TriggerEvent('es:addGroupCommand', 'revive', 'admin', function(source, args, user)
	if args[1] ~= nil then
		if GetPlayerName(tonumber(args[1])) ~= nil then
			print('a_ems: ' .. GetPlayerName(source) .. ' is reviving a player!')
			TriggerClientEvent('a_ems:revive', tonumber(args[1]))
		end
	else
		TriggerClientEvent('a_ems:revive', source)
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, { help = _U('revive_help'), params = { { name = 'id' } } })

ESX.RegisterUsableItem('medikit', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeInventoryItem('medikit', 1)
	TriggerClientEvent('a_ems:heal', _source, 'big')
	TriggerClientEvent('esx:showNotification', _source, _U('used_medikit'))
end)

ESX.RegisterUsableItem('bandage', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeInventoryItem('bandage', 1)
	TriggerClientEvent('a_ems:heal', _source, 'small')
	TriggerClientEvent('esx:showNotification', _source, _U('used_bandage'))
end)

RegisterServerEvent('a_ems:firstSpawn')
AddEventHandler('a_ems:firstSpawn', function()
	local _source    = source
	local identifier = GetPlayerIdentifiers(_source)[1]
	MySQL.Async.fetchScalar('SELECT isDead FROM users WHERE identifier=@identifier',
		{
			['@identifier'] = identifier
		}, function(isDead)
			if isDead == 1 then
				print('a_ems: ' .. GetPlayerName(_source) .. ' (' .. identifier .. ') attempted combat logging!')
				TriggerClientEvent('a_ems:requestDeath', _source)
			end
		end)
end)

RegisterServerEvent('a_ems:setDeathStatus')
AddEventHandler('a_ems:setDeathStatus', function(isDead)
	local _source = source
	MySQL.Sync.execute("UPDATE users SET isDead=@isDead WHERE identifier=@identifier",
		{
			['@identifier'] = GetPlayerIdentifiers(_source)[1],
			['@isDead'] = isDead
		})
end)
