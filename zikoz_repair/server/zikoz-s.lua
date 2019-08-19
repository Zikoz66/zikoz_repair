ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('BuyKit')
AddEventHandler('BuyKit', function()
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(source)
    local price = Config.PriceKit
    xPlayer.removeMoney(price)
    xPlayer.addInventoryItem('fixkit', 1)
end)

RegisterServerEvent('BuyCaro')
AddEventHandler('BuyCaro', function()
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(source)
    local price = Config.PriceCaro
    xPlayer.removeMoney(price)
    xPlayer.addInventoryItem('carokit', 1)
end)

